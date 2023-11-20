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
}
