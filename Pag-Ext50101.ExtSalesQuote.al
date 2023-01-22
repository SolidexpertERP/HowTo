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
            action(SendNotyf)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Notyfication: Codeunit "Notyfication Document";
                begin
                    Notyfication.SendDocument(Rec, Enum::"Notyfication Type"::"E-mail");
                end;
            }
        }
    }
}
