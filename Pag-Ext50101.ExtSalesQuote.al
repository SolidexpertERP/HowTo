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
            action(SendNotyf2)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Notyfication: Codeunit "Master Managament";
                begin
                    Notyfication.DocumentNotification(Rec);
                end;
            }
            action(SetAndGetText)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TwoInt: Codeunit "Two Interface Manahament";
                    ISet: Interface "ISet Object";
                    IGet: Interface "IGet Object";
                    Txt: Text;
                begin
                    ISet := TwoInt;
                    IGet := TwoInt;

                    ISet.SetText('SOLIDEXPERT');
                    IGet.GetText(Txt);

                    Message(Txt);
                end;
            }
            action(CreateSalesOrder)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CreateSalesOrder: Codeunit "Create Sales Order KPI";
                begin
                    CreateSalesOrder.CreateSalesOrder();
                end;
            }
            action(Testowanko)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Test();
                end;
            }
            action(WorkWithError)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"Work With Error", Rec);
                end;
            }
            action(WorkWithSplitText)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TxtCU: Codeunit "Work With Split Text";
                begin
                    TxtCU.SplitText();
                end;
            }
            action(AktualizujPage)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CU: Codeunit "Update Page From Table";
                begin
                    CU.RunUpdatePage();
                end;
            }
        }
    }

    local procedure Test()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine := SearchSalesLine();
        if SalesLine."Document No." = '' then
            Message('Errorus potengus');
    end;

    local procedure SearchSalesLine(): Record "Sales Line"
    var
        Line: Text;
        LineNo: Integer;
    begin
        Line := '00010';
        Evaluate(LineNo, Line);
        Message(Format(LineNo));

        Line := '00110';
        Evaluate(LineNo, Line);
        Message(Format(LineNo));
    end;
}
