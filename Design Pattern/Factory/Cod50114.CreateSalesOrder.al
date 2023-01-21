codeunit 50114 "Create Sales Order" implements IDocument
{

    procedure CreateDocument()
    begin
        CreateSalesOrder();
    end;

    local procedure CreateSalesOrder()
    begin
        Message('Hello create Sales Order');
    end;

}
