codeunit 50138 "Work With Record"
{
    /// <summary>
    /// Procedura mająca na celu sprawdzenie czy jeżeli funkcja GetCustomer zwraca Customer.FindFirst to czy w funkcji Update Customer mamy dostępny rekord, czy na nowo musimy wywołać funckje findfirst
    /// </summary>
    procedure FindDocument()
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        if GetCustomer(Customer) then
            UpdateVendor(Customer, Vendor)
        else
            Message('Bleeee...not find first Customer');
    end;

    local procedure GetCustomer(var Customer: Record Customer): Boolean
    begin
        exit(Customer.FindFirst());
    end;

    local procedure UpdateVendor(Customer: Record Customer; Vendor: Record Vendor)
    begin
        // Tutaj już nie musimy zrobić FindFirst, jest Ono zrobione wczęsniej więc mamy już w rekordzie konkretnego Customer'a
        Message('Hello im: %1 from UpdateVendor', Customer."No.");
    end;
    /////////////////////////////////////////////////////////////////////////////////////////////////////

    /// <summary>
    /// Funkcja mająca na celu sprawdzenie czy jeżeli nałożymy jakieś filtry to możemy modyfikować wiele różnych kolumn bez konieczności pętli po rekordach...
    /// </summary>
    procedure ModifyAll()
    var
        SalesHeader: Record "Sales Header";
        NewGuid: Guid;
        Val1: Code[10];
        Val2: Code[10];
        Val3: Code[10];
    begin
        NewGuid := CreateGuid();
        Val1 := CopyStr(NewGuid, 1, MaxStrLen(Val1) - 3) + '-M1';
        Val2 := CopyStr(NewGuid, 1, MaxStrLen(Val1) - 3) + '-M2';
        Val3 := CopyStr(NewGuid, 1, MaxStrLen(Val1) - 3) + '-M3';

        SalesHeader.SetRange("Sell-to Customer No.", '10000');
        if SalesHeader.FindSet() then begin
            SalesHeader.ModifyAll("External Document No.", Val1);
            SalesHeader.ModifyAll("Location Code", Val2);
            SalesHeader.ModifyAll("Assigned User ID", Val3);
        end;
    end;

    procedure TransferFields()
    var
        FromPurchaseLine: Record "Purchase Line";
        NewPurchaseLine: Record "Purchase Line";
    begin
        NewPurchaseLine.Init();
        NewPurchaseLine.InitNewLine(NewPurchaseLine);
        NewPurchaseLine."Line No." += 10000; // PK3
        NewPurchaseLine.Validate("Document Type", NewPurchaseLine."Document Type"::Order); // PK1
        NewPurchaseLine.Validate("Document No.", 'ZZ/2023/0001'); // PK2
        NewPurchaseLine.TransferFields(FromPurchaseLine, false); // Transferuje wszystkie pola oprócz pól PK
        NewPurchaseLine.Insert(true);
    end;

    /// <summary>
    /// Sprawdzenie czy przekazany do procedury var PurchLine, podczas wykonywania pętli, w momencie kiedy natrafi na wiersz numer 30000
    /// zatrzyma się i zwróci wiersz na którym się zatrzymał, czy cały set danych z filtru założonego przed pętlą
    /// ODP: Tak zwraca konktrtny wiersz na którym się zatrzymał
    /// </summary>
    /// <param name="PurchLine"></param>
    internal procedure LineNoFilter(var PurchLine: Record "Purchase Line")
    var
        LineNoTxt: Text;
    begin
        LineNoTxt := '30000';
        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange("Document No.", '106001');
        if PurchLine.FindSet() then
            repeat
                if LineNoTxt = Format(PurchLine."Line No.", 5) then
                    exit;
            until PurchLine.Next() < 1;
    end;


    /// <summary>
    /// Zastosowanie filtru: 
    /// WHERE "Document Type" = SalesHeader."Document Type"::Order AND ("No." = '101001' OR "Sell-to Customer No." = '30000' OR "Sell-to Customer Name" = 'Relecloud')
    /// </summary>
    procedure OrFilter()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.FilterGroup(2);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.FilterGroup(-1);
        SalesHeader.SetFilter("No.", '101001');
        SalesHeader.SetFilter("Sell-to Customer No.", '30000');
        SalesHeader.SetFilter("Sell-to Customer Name", 'Relecloud');
        if SalesHeader.FindSet() then
            repeat
                Message(SalesHeader."No.");
            until SalesHeader.Next() < 1;
    end;

    internal procedure AdHockTest()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.FilterGroup(2);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.FilterGroup(-1);
        SalesHeader.SetFilter("No.", '101001');
        SalesHeader.SetFilter("Sell-to Customer No.", '30000');
        SalesHeader.SetFilter("Sell-to Customer Name", 'Relecloud');
        if SalesHeader.FindSet() then
            repeat
                Message(SalesHeader."No.");
            until SalesHeader.Next() < 1;
    end;

    procedure WorkWithTestField()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.FindFirst();
        SalesHeader.TestField(Status, SalesHeader.Status::Released, ErrorInfo.Create('Jakiś tam mój błąd'));
    end;

    /// <summary>
    /// Procedura mająca na celu sprawdzenie jak zadziała przekazywanie zmiennej z var i bez var i odświeżanie jej danymi z bazy danych
    /// </summary>
    /// <param name="SalesHeader"></param>
    procedure HowWorkVariableWithVar(var SalesHeader: Record "Sales Header")
    begin
        // Ustawiam na Step 1
        SalesHeader."My Field Test" := 'Step 1';
        // Ustawienie pola na Step 2 procedurą bez Var i Modify()
        SetMyFiled(SalesHeader);
        // Jest "Step 1" ponieważ utracono to co ustawiono w proc. SetMyFiled ponieważ przekazano tam bez Var i bez Modify()
        Message(SalesHeader."My Field Test");
        // Odświeżenia Rec aktualnymi danymi z bazy danych i sprawdzenie czy aby na pewno utracono dane i jest Step 4 czyli to co jest w bazie danych, czyli przywracamy record do stanu pierwotnego bo to tej pory nie było nigdzie Modify()
        SalesHeader.Get(SalesHeader.RecordId);
        Message(SalesHeader."My Field Test");
        // Ustawienie pola na Step 2 bez Var ale z Modify() 
        SetMyFiled1(SalesHeader);
        // Odświeżenia Rec aktualnymi danymi z bazy danych 
        SalesHeader.Get(SalesHeader.RecordId);
        // Jest Step 2 pomimo, że przekazano do SetMyFiled1 bez var, ale zrobiono tam modify a następnie odświeżno sobie record aktualnymi danymi z bazy danych
        Message(SalesHeader."My Field Test");
        SalesHeader."My Field Test" := 'Step 3';
        SetMyFiled2(SalesHeader);
        Message(SalesHeader."My Field Test"); // Jest "Step 4" czyli wartość ustawiona w proc. SetMyFiled2 bo przekazano tam z Var
    end;

    local procedure SetMyFiled(SalesHeader: Record "Sales Header")
    begin
        // Sprawdzenie jaką wartość ma pole "My Field Test" które ustawiono we wcześniejszej proc.
        // Jest: 'Step 1' ponieważ przekazano kopię stanu obecnego, pomimo braku Modify() w poprzedniej procedurze
        Message(SalesHeader."My Field Test");
        SalesHeader."My Field Test" := 'Step 2';
    end;

    local procedure SetMyFiled1(SalesHeader: Record "Sales Header")
    begin
        // Sprawdzenie jaką wartość ma pole "My Field Test" które ustawiono we wcześniejszej proc.
        // Jest: 'Step 1' ponieważ przekazano kopię stanu obecnego, pomimo braku Modify() w poprzedniej procedurze
        Message(SalesHeader."My Field Test");
        SalesHeader."My Field Test" := 'Step 2';
        SalesHeader.Modify();
    end;

    local procedure SetMyFiled2(var SalesHeader: Record "Sales Header")
    begin
        // Sprawdzenie jaką wartość ma pole "My Field Test" które ustawiono we wcześniejszej proc.
        // Powinno być: 'Step 1'
        Message(SalesHeader."My Field Test");
        SalesHeader."My Field Test" := 'Step 4';
    end;




}
