codeunit 50102 "Create Document" implements "ICreate Document"
{

    procedure CreateDocument(Document: Variant): Variant
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.FindFirst();
        exit(SalesHeader);
    end;

    procedure DeleteDocument(Document: Variant): Variant
    begin
        exit('Usuwanie dokumentu...');
    end;

}
