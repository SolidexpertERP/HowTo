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
}
