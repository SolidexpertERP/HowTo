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
}
