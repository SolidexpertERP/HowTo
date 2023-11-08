pageextension 50105 "Ext Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("My Quantity 1"; Rec."My Quantity 1")
            {
                ApplicationArea = All;
            }
            field("My Quantity 2"; Rec."My Quantity 2")
            {
                ApplicationArea = All;
            }
        }
    }
}
