pageextension 50107 "BE Issued Reminder" extends "Issued Reminder"
{
    actions
    {
        addafter("&Reminder")
        {
            action("Send Report As PDF via Email")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Email;

                trigger OnAction()
                var
                    WorkWithReport: Codeunit "Work With Report";
                begin
                    WorkWithReport.SendDocumentEmail(Rec);
                end;
            }
        }
    }
}
