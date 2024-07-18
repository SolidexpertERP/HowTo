pageextension 50102 "Ext Sales Order" extends "Sales Order"
{

    layout
    {
        addlast(General)
        {
            field("Sales Header Counter"; Rec."Sales Header Counter")
            {
                ApplicationArea = All;
            }
            field("My New Document Date"; Rec."My New Document Date")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action("Multiple Func")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With RecRef FieldRef";
                begin
                    WorkWith.CheckAndUpdateDocumentDate(Rec.RecordId, Rec."My New Document Date");
                end;
            }
            action("My Func")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With RecRef FieldRef";
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."No.");
                    WorkWith.SendSetToVariable(SalesLine);
                end;
            }
            action("Duplicate First Sales Line")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    NewSalesLine: Record "Sales Line";
                begin
                    if SalesLine.Get(Rec."Document Type", Rec."No.", 10000) then begin
                        NewSalesLine.Init();
                        NewSalesLine."Document Type" := Rec."Document Type";
                        NewSalesLine."Document No." := Rec."No.";
                        NewSalesLine.InitNewLine(NewSalesLine);
                        NewSalesLine."Line No." += 10000;
                        NewSalesLine.Insert(true);
                        NewSalesLine.Validate("My Quantity 1", 100);
                        NewSalesLine.Modify(true);
                    end;
                end;
            }
            action(CalcSumLine)
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.CalcSums(Quantity);
                    if SalesLine.FindSet() then begin
                        Message('Before: ' + Format(SalesLine.Quantity)); // Tutaj widzi to jako zsumowaną wartość
                        repeat
                            Message(Format(SalesLine.Quantity)); // po pobraniu rekordu, widzi już jako ilość poszczególnego wiersza 
                        until SalesLine.Next() < 1;
                        Message('After: ' + Format(SalesLine.Quantity)); // tutaj widzi ilość wiersza z ostatniej iteracji pętli
                    end;
                end;
            }
            action("SEND SMS Method 1")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Calls;

                trigger OnAction()
                var
                    WorkWithAPI: Codeunit "Work With API";
                begin
                    WorkWithAPI.APISMS();
                end;
            }
            action("SEND SMS Method 2")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Calls;

                trigger OnAction()
                var
                    WorkWithAPI: Codeunit "Work With API";
                begin
                    WorkWithAPI.APISMS2();
                end;
            }
            action("Some API")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Web;

                trigger OnAction()
                var
                    WorkWithAPI: Codeunit "Work With API";
                begin
                    WorkWithAPI.SomeApi();
                end;
            }
            action("Weather API")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Web;

                trigger OnAction()
                var
                    WorkWithAPI: Codeunit "Work With API";
                begin
                    WorkWithAPI.WeatherAPI();
                end;
            }
            action("OAuth 2.0")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Web;
                Caption = 'OAuth 2.0';

                trigger OnAction()
                var
                    OAuth: Codeunit "OAuth 2.0";
                begin
                    OAuth.OAuth();
                end;
            }
            action("Send Email")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Email;

                trigger OnAction()
                var
                    Email: Codeunit "Work With Email";
                begin
                    Email.SendEmail();
                end;
            }
            action("Send Remider")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Email;

                trigger OnAction()
                var
                    IssuedReminderHeader: Record "Issued Reminder Header";
                begin
                    IssuedReminderHeader.FindFirst();
                    IssuedReminderHeader.PrintRecords(false, true, true);
                    Message('Poszło %1', IssuedReminderHeader."No.");
                end;
            }
            action("Show Report Param")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Email;

                trigger OnAction()
                var
                    WorkWithReport: Codeunit "Work With Report";
                begin
                    WorkWithReport.GetReportParams();
                end;
            }
            action("Save Report As PDF")
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Email;

                trigger OnAction()
                var
                    WorkWithReport: Codeunit "Work With Report";
                begin
                    WorkWithReport.RunReportWithoutRequestPageAndSaveToPDF();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Rec.FilterGroup(0);
        //Rec.SetRange("ITI Sales Date", Today);
    end;
}
