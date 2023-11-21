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
        }
    }

    actions
    {
        addfirst(processing)
        {
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
        }
    }

    trigger OnOpenPage()
    begin
        //Rec.FilterGroup(0);
        //Rec.SetRange("ITI Sales Date", Today);
    end;
}
