pageextension 50101 "Ext Sales Quote" extends "Sales Quote"
{
    actions
    {
        addafter("&View")
        {
            action(VATStatus)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CheckVATStatus: Codeunit ITICheckVATStatus;
                    TxtMsg: Label 'Hekko';
                begin
                    CheckVATStatus.CheckCustomerVATStatusAndUpdateDocument(Rec, true);
                    Message(TxtMsg);
                end;
            }
        }
    }
}
