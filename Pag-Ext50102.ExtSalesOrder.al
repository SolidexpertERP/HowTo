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
                    WorkWith: Codeunit "Work With Record";
                begin
                    WorkWith.SetMyFilter(Rec);
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
