/// <summary>
/// Codeunit mający na celu utworzenie dokumentu z dowolnego rekordu.
/// Wszystko odbywa się poprzez przyjęcie w postaci zmiennej "FromDocument: Variant" dowolnego rekordu, z dowolnego Page, następnie pobranie jego referencji i odczytanie z referencji 
/// pól o określonych nazwach zamieszczonych w nich wartości, wymaganych do utworzenia dokumentu. Tabela "Data To Create Document" to tabela do której są dekodowane zmienne
/// ponieważ docelowo ma postać jedna funkcja tworząca dokument ShippingDocument (jakiś wymyślony dokument) na podtsawie danych z tej tabeli
/// </summary>
codeunit 50136 "Create Document Managament"
{
    var
        DataTypeMgt: Codeunit "Data Type Management";
        FromRecRef: RecordRef;
        DataToCreateDocument: Record "Data To Create Document" temporary;

    procedure CreateShippingDocument(FromDocument: Variant)
    begin
        DataTypeMgt.GetRecordRef(FromDocument, FromRecRef);
        CreateDocument(FromRecRef);
    end;

    local procedure CreateDocument(FromRecRef: RecordRef)
    begin
        InitDataToCreateDocument(FromRecRef);
        if not DataToCreateDocument.IsEmpty then
            CreateShippingDocumentFromDataToCreateDocument();
    end;

    local procedure InitDataToCreateDocument(FromRecRef: RecordRef)
    var
        FldRef: FieldRef;
    begin
        DataToCreateDocument.DeleteAll();
        DataToCreateDocument.Init();
        DataToCreateDocument."Document No." := FromRecRef.Name;

        if GetFieldRef(FromRecRef, FldRef, DataToCreateDocument.FieldName("Ship-to Name")) then
            DataToCreateDocument."Ship-to Name" := FldRef.Value;
        if GetFieldRef(FromRecRef, FldRef, DataToCreateDocument.FieldName(Address)) then
            DataToCreateDocument."Name 2" := FldRef.Value;
        if GetFieldRef(FromRecRef, FldRef, DataToCreateDocument.FieldName(City)) then
            DataToCreateDocument.City := FldRef.Value;
        if GetFieldRef(FromRecRef, FldRef, DataToCreateDocument.FieldName("Name 2")) then
            DataToCreateDocument.Address := FldRef.Value;
        if GetFieldRef(FromRecRef, FldRef, DataToCreateDocument.FieldName(Amount)) then
            DataToCreateDocument.Amount := FldRef.Value;

        DataToCreateDocument.Insert();
    end;

    local procedure CreateShippingDocumentFromDataToCreateDocument()
    var
        DocumentNo: Code[100];
        Name: Code[50];
        Surname: Code[80];
        Street: Code[80];
        City: Code[50];
        Amount: Decimal;
    begin
        DataToCreateDocument.FindFirst();
        DocumentNo := DataToCreateDocument."Document No.";
        Name := DataToCreateDocument."Ship-to Name";
        Surname := DataToCreateDocument."Name 2";
        Street := DataToCreateDocument.Address;
        City := DataToCreateDocument.City;
        Amount := DataToCreateDocument.Amount;

        Message('%1\%2 %3\%4 %5\%6', DocumentNo, Name, Surname, Street, City, Amount);
    end;

    local procedure GetFieldRef(FromRecRef: RecordRef; var FldRef: FieldRef; FieldName: Text): Boolean
    var
        FldRefIndex: Integer;
    begin
        FldRefIndex := GetFieldIndex(FromRecRef.Number, FieldName);
        FldRef := FromRecRef.Field(FldRefIndex);
        exit(FldRefIndex <> 0);
    end;

    local procedure GetFieldIndex(TableNo: Integer; FieldName: Text): Integer
    var
        Fields: Record Field;
    begin
        Fields.SetRange(TableNo, TableNo);
        Fields.SetRange(FieldName, FieldName);
        if Fields.FindFirst() then
            exit(Fields."No.");
    end;
}
