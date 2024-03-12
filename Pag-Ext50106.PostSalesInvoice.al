pageextension 50106 "Post Sales Invoice" extends "Posted Sales Invoice"
{
    actions
    {
        addafter("Update Document")
        {
            action(CallServices)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HttpMgt: Codeunit "Http Managament";
                begin
                    HttpMgt.GetPDFInvoice(Rec);
                end;
            }
        }
    }
}
