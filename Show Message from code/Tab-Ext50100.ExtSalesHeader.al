tableextension 50100 "Ext Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "My Communicat Field"; Text[100])
        {
            Caption = 'My Comunicat Field';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Message(Rec."My Communicat Field");
            end;
        }
    }
}
