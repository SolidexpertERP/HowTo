codeunit 50112 "Invoice Builder"
{
    var
        SalesInvoice: Record "Sales Header";
        SalesInvoiceLine: Record "Sales Line";

    procedure Build(): Record "Sales Header"
    begin
        exit(SalesInvoice);
    end;

    procedure Init()
    begin
        SalesInvoice.Init();
        SalesInvoice."Document Type" := SalesInvoice."Document Type"::Invoice;
        SalesInvoice."No." := 'FS001/02/2023';
        SalesInvoice.Insert();
    end;


    procedure SetCustomer(CustomerNo: Code[20])
    begin
        SalesInvoice.Validate("Bill-to Customer No.", CustomerNo);
    end;

    procedure SetDate(Date: Date)
    begin
        SalesInvoice."Posting Date" := Date;
        SalesInvoice."Due Date" := Date;
        SalesInvoice."Order Date" := Date;
    end;

    procedure SetSalesLine(Items: Record Item)
    begin
        if SalesInvoiceLine.FindSet() then
            repeat
                SalesInvoiceLine.Init();
                SalesInvoiceLine."Document No." := SalesInvoice."No.";
                SalesInvoiceLine."Document Type" := SalesInvoice."Document Type";
                SalesInvoiceLine.Validate("No.", Items."No.");
                SalesInvoiceLine.Insert(true);
            until SalesInvoiceLine.Next() = 0;
    end;
}
