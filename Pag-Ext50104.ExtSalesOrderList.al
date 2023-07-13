pageextension 50104 "Ext Sales Order List" extends "Sales Order List"
{
    actions
    {
        addafter("&Order Confirmation")
        {

            action("Calc Date MS Example")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With Date";
                begin
                    WorkWith.CalculateDate2();
                end;
            }
            action("Calc Last 12 Month Date")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With Date";
                begin
                    WorkWith.CalculateDate();
                end;
            }
            action("Calc Previous 12 Month Date")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With Date";
                begin
                    WorkWith.CalculateDate1();
                end;
            }
            action("Pad String")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With Split Text";
                begin
                    WorkWith.PadString();
                end;
            }
            action("Format Txt")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With Split Text";
                begin
                    WorkWith.FormatTxt();
                end;
            }
            action("Encoding Table Name")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With RecRef FieldRef";
                    RecRef: RecordRef;
                begin
                    WorkWith.WorkWithVariant(Rec);
                    WorkWith.WorkWithVariant(Rec.RecordId);

                    RecRef.Get(Rec.RecordId);
                    WorkWith.WorkWithVariant(RecRef);
                end;
            }
            action("Modify All")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWithRecord: Codeunit "Work With Record";
                begin
                    WorkWithRecord.ModifyAll();
                    CurrPage.Update();
                end;
            }
            action("Mark rekords")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesHeader2: Record "Sales Header";
                    SalInvPage: Page "Sales Invoice List";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                    if SalesHeader.FindSet() then
                        repeat
                            if SalesHeader."Sell-to Customer No." = '10000' then begin
                                SalesHeader.CalcFields(Amount);
                                if SalesHeader.Amount < 1000 then
                                    SalesHeader.Mark(true);
                            end;
                        until SalesHeader.Next() < 1;

                    SalesHeader.MarkedOnly(true);
                    SalInvPage.SetTableView(SalesHeader);
                    SalInvPage.Run();
                end;
            }
            action(GetCustomerTEST)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWithRecord: Codeunit "Work With Record";
                begin
                    WorkWithRecord.FindDocument();
                end;
            }
        }
    }

    // trigger OnOpenPage()
    // var
    //     SalesHeader: Record "Sales Header";
    // begin
    //     SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
    //     if SalesHeader.FindSet() then
    //         repeat
    //             if SalesHeader."Sell-to Customer No." = '10000' then
    //                 SalesHeader.Mark(true);
    //         until SalesHeader.Next() < 1;

    //     CurrPage.SetSelectionFilter(SalesHeader);
    //     CurrPage.SetRecord(SalesHeader);
    // end;
}