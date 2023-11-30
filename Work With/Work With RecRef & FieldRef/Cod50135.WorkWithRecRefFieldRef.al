codeunit 50135 "Work With RecRef FieldRef"
{
    procedure UpdateCity(RecordToUpdate: Variant; NewCityName: Code[20]; FieldNo: Integer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        if NewCityName = 'RZESZÓW' then
            Error('Nie możesz wprowadzić RZESZÓW');

        DataTypeMgt.GetRecordRef(RecordToUpdate, RecRef);
        FldRef := RecRef.Field(FieldNo);
        FldRef.Validate(NewCityName);
        RecRef.Modify(true);
    end;

    local procedure SetFilter(var Rec: Record Customer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRefNo: FieldRef;
    begin
        RecRef.Open(Rec.RecordId.TableNo);
        RecRef.Copy(Rec);
        if DataTypeMgt.FindFieldByName(RecRef, FldRefNo, 'No.') then
            FldRefNo.SetFilter('10000');
        RecRef.SetTable(Rec);
    end;

    local procedure SetFilter2(var Rec: Record Customer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRefNo: FieldRef;
    begin
        RecRef.Open(Rec.RecordId.TableNo);
        RecRef.Copy(Rec);
        if DataTypeMgt.FindFieldByName(RecRef, FldRefNo, 'Name') then
            FldRefNo.SetFilter('Adatum Corporation');
        RecRef.SetTable(Rec);
    end;

    local procedure SetFilterVariant(RecVariant: Variant): Variant
    var
        DataTypeMgt: Codeunit "Data Type Management";
        OutVariant: Variant;
        RecRef: RecordRef;
        FldRefNo: FieldRef;
    begin
        DataTypeMgt.GetRecordRef(RecVariant, RecRef);
        if DataTypeMgt.FindFieldByName(RecRef, FldRefNo, 'Name') then
            FldRefNo.SetFilter('ALA');
        RecRef.GetTable(OutVariant);
    end;

    procedure ShowMessage(Document: Variant)
    var
        DataMgt: Codeunit "Data Type Management";
        IDRecord: RecordId;
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        if Document.IsRecordId then
            IDRecord := Document;

        RecRef := IDRecord.GetRecord();
        DataMgt.FindFieldByName(RecRef, FldRef, 'No.');
        Message('%1', FldRef.Value);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer List", 'OnOpenPageEvent', '', true, true)]
    local procedure SetFilterCustomerList(var Rec: Record Customer)
    begin
        SetFilter(Rec);
        SetFilter2(Rec);
        //Rec := SetFilterVariant(Rec); // <- przez Variant nie działa...
    end;

    /// <summary>
    /// Funkcja do dekodowania Variant na RecRef
    /// </summary>
    /// <param name="FromDoc"></param>
    procedure FindLineAndCheck(FromDoc: Variant)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        DocumentToCheck: RecordRef;
    begin
        DataTypeMgt.GetRecordRef(FromDoc, DocumentToCheck);
        SearchAndCheckLine(DocumentToCheck);
    end;

    /// <summary>
    /// Funkcja która na podstawie RecRef sprawdza jaka to tabel i otwiera jej wiersze
    /// </summary>
    /// <param name="DocumentToCheck"></param>
    local procedure SearchAndCheckLine(DocumentToCheck: RecordRef)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        LineToCheck: RecordRef;
        FRDoucmentNoLine: FieldRef;
        FRDoucmentNoHeader: FieldRef;
        DocumentNo: Code[20];
        SalesLine: Record "Sales Line";
    begin
        if not DataTypeMgt.FindFieldByName(DocumentToCheck, FRDoucmentNoHeader, 'No.') then
            exit;

        case DocumentToCheck.Number of
            Database::"Sales Header":
                LineToCheck.Open(Database::"Sales Line");
            else
                exit;
        end;

        DataTypeMgt.FindFieldByName(LineToCheck, FRDoucmentNoLine, 'Document No.');
        FRDoucmentNoLine.SetRange(FRDoucmentNoHeader.Value);

        if LineToCheck.FindSet() then
            repeat
                SalesLine.Get(LineToCheck.RecordId);
                Message('%1 %2 %3', SalesLine."Document No.", SalesLine."Line No.", SalesLine."No.");
            until LineToCheck.Next() < 1;
    end;

    /// <summary>
    /// Funkcja mająca na celu przyjąć dowolny Variant i sprowadzić go do RecRef
    /// </summary>
    /// <param name="Document"></param>
    procedure WorkWithVariant(Document: Variant)
    var
        DataMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FromTxt: Text;
    begin
        if Document.IsRecordRef then begin
            RecRef := Document;
            FromTxt := 'IsRecordRef';
        end;

        if Document.IsRecord then begin
            DataMgt.GetRecordRef(Document, RecRef);
            FromTxt := 'IsRecord';
        end;

        if Document.IsRecordId then begin
            RecRef.Get(Document);
            FromTxt := 'IsRecordId';
        end;

        Message('RecRef.Name: %1 (%2)', RecRef.Name, FromTxt);
    end;


    /// <summary>
    /// Funkcja do otwarcia dowolnego rekordu po jego ID i rozkręcenie pętli
    /// </summary>
    /// <param name="DatabaseID"></param>
    procedure OpenRecAndWhile(DatabaseID: Integer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.Open(DatabaseID);
        if RecRef.FindSet() then
            repeat
                if DataTypeMgt.FindFieldByName(RecRef, FldRef, 'No.') then
                    Message(Format(FldRef.Value));
            until RecRef.Next() < 1;
    end;

    /// <summary>
    /// Co się stanie jeżeli w tabeli nie będzie pola o podanej nazwie
    /// </summary>
    /// <param name="RecVariant"></param>
    procedure TestGetFakeField(RecVariant: Variant)
    var
        DataMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRef: FieldRef;
        NoVal: Code[20];
    begin
        DataMgt.GetRecordRef(RecVariant, RecRef);

        if DataMgt.FindFieldByName(RecRef, FldRef, 'Dupsko Zbite') then
            NoVal := FldRef.Value;
        Message('FldRef Dupsko Blade: %1', NoVal); // tutaj po prostu nie pobierze zmiennej

        DataMgt.FindFieldByName(RecRef, FldRef, 'Dupsko Zbite');
        NoVal := FldRef.Value; // Wywali błąd że zmienna nie została zainicjowana
        Message('FldRef Dupsko Blade: %1', NoVal);
    end;

    /// <summary>
    /// Sparawdzenie co się stanie jak do Variant prześlę jakiegoś Seta np. Sales Line przefiltrowane po numerze dokumentu
    /// </summary>
    /// <param name="RecVariant"></param>
    procedure SendSetToVariable(RecVariant: Variant)
    var
        DataMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        DataMgt.GetRecordRef(RecVariant, RecRef); // Tutaj pobierze sobie recref z filtrami jeżeli będą
        Message(RecRef.GetFilters); // Tutaj będzie informacja o nałożonym filtrze "Nr Dokumentu": XYZ..
        if RecRef.FindSet() then // Jeżeli pod RecVariant będzie się kryż przefiltrowany data set to można od razu rozkręcać pętle 
            repeat
                DataMgt.FindFieldByName(RecRef, FldRef, 'No.'); //Wyświetli numer 
                Message(FldRef.Value());
            until RecRef.Next() < 1;
    end;

    /// <summary>
    /// Kopiowanie filtrów pomiędzy dwiema różnymi tabelami na podstawie znalezionych pól o takiej samej nazwie i typie z wykorzystaniem Variant
    /// </summary>
    /// <param name="FromRec"></param>
    /// <param name="ToRec"></param>
    internal procedure CopyFilters(var FromRec: Record "Sales Header"; var ToRec: Record Job)
    var
        FromRecVariant: Variant;
        ToRecVariant: Variant;
        FromRecFilterGroup: Integer;
        ToRecFilterGroup: Integer;
    begin
        FromRecVariant := FromRec; // Kopiowanie rekordu do Variant
        ToRecVariant := ToRec;
        FromRecFilterGroup := 0;
        ToRecFilterGroup := 2;
        CopyFiltersTransfer(FromRecVariant, FromRecFilterGroup, ToRecVariant, ToRecFilterGroup);
        ToRec.CopyFilters(ToRecVariant); // zaaplikowanie filtrów do docelowego rekordu z Variant
    end;

    /// <summary>
    /// Transferowanie filtrów pomiędzy dwoma tabelami z wykorzystaniem Variant
    /// </summary>
    /// <param name="FromRecord"></param>
    /// <param name="FromFilterGroup"></param>
    /// <param name="ToRecord"></param>
    /// <param name="ToFilterGroup"></param>
    internal procedure CopyFiltersTransfer(var FromRecord: Variant; FromFilterGroup: Integer; var ToRecord: Variant; ToFilterGroup: Integer)
    var
        DataTypMgt: Codeunit "Data Type Management";
        FromRecRef: RecordRef;
        ToRecRef: RecordRef;
        FromFldRef: FieldRef;
        ToFldRef: FieldRef;
        FromField: Record "Field";
        ToField: Record "Field";
        FromFieldFilterTxt: Text;
    begin
        if not DataTypMgt.GetRecordRef(FromRecord, FromRecRef) then
            exit;
        if not DataTypMgt.GetRecordRef(ToRecord, ToRecRef) then
            exit;

        FromRecRef.FilterGroup(FromFilterGroup);
        ToRecRef.FilterGroup(ToFilterGroup);

        FromField.SetRange(TableNo, FromRecRef.Number);
        if FromField.FindSet() then
            repeat
                FromFldRef := FromRecRef.Field(FromField."No.");
                FromFieldFilterTxt := FromFldRef.GetFilter();
                if FromFieldFilterTxt <> '' then begin
                    ToField.SetRange(TableNo, ToRecRef.Number);
                    ToField.SetRange(FieldName, FromField.FieldName);
                    ToField.SetRange(Type, FromField.Type);
                    if ToField.FindFirst() then begin
                        ToFldRef := ToRecRef.Field(ToField."No.");
                        ToFldRef.SetFilter(FromFieldFilterTxt);
                    end;
                end;
            until FromField.Next() < 1;

        ToRecord := ToRecRef; // Przenoszenie do Variantu naniesionych zmian 
    end;

    /// <summary>
    /// Kopiowanie filtrów pomiędzy dwiema różnymi tabelami na podstawie znalezionych pól o takiej samej nazwie i typie z wykorzystaniem RecordRef
    /// </summary>
    /// <param name="FromRec"></param>
    /// <param name="ToRec"></param>
    procedure CopyFilters2(var FromRec: Record "Sales Header"; var ToRec: Record Job)
    var
        FromRecRef: RecordRef;
        ToRecRef: RecordRef;
    begin
        FromRecRef.GetTable(FromRec); // Pobranie tabeli do RecRef
        ToRecRef.GetTable(ToRec);
        CopyFiltersTransfer2(FromRecRef, 0, ToRecRef, 2); // Transfer pól
        ToRecRef.SetTable(ToRec); // Zaaplikowanie na Record ToRec filtrów z ToRecRef
    end;

    /// <summary>
    /// Transfer filtrów pomiędzy polami
    /// </summary>
    /// <param name="FromRecRef"></param>
    /// <param name="FromFilterGroup"></param>
    /// <param name="ToRecRef"></param>
    /// <param name="ToFilterGroup"></param>
    procedure CopyFiltersTransfer2(var FromRecRef: RecordRef; FromFilterGroup: Integer; var ToRecRef: RecordRef; ToFilterGroup: Integer)
    var
        FromFldRef: FieldRef;
        ToFldRef: FieldRef;
        FromField: Record "Field";
        ToField: Record "Field";
        FromFieldFilterTxt: Text;
    begin
        FromRecRef.FilterGroup(FromFilterGroup);
        ToRecRef.FilterGroup(ToFilterGroup);

        FromField.SetRange(TableNo, FromRecRef.Number);
        if FromField.FindSet() then
            repeat
                FromFldRef := FromRecRef.Field(FromField."No.");
                FromFieldFilterTxt := FromFldRef.GetFilter();
                if FromFieldFilterTxt <> '' then begin
                    ToField.SetRange(TableNo, ToRecRef.Number);
                    ToField.SetRange(FieldName, FromField.FieldName);
                    ToField.SetRange(Type, FromField.Type);
                    if ToField.FindFirst() then begin
                        ToFldRef := ToRecRef.Field(ToField."No.");
                        ToFldRef.SetFilter(FromFieldFilterTxt);
                    end;
                end;
            until FromField.Next() < 1;
    end;
}
