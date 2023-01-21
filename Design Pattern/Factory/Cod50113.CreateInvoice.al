codeunit 50113 "Create Invoice" implements IDocument
{

    procedure CreateDocument()
    begin
        CreateInvoice();
    end;

    local procedure CreateInvoice()
    begin
        Message('Create Invoice');
    end;

}
