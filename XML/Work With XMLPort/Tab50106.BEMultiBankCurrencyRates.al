table 50106 "BE MultiBank Currency Rates"
{
    Caption = 'BE MultiBank Currency Rates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Field001; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(2; Field002; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(3; Field003; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(4; Field004; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(5; Field005; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; Field006; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(7; Field007; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(8; Field008; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        MultiBank: Record "BE MultiBank Currency Rates";
    begin
        if MultiBank.FindLast() then
            Rec."Entry No" := MultiBank."Entry No" + 1;
    end;
}
