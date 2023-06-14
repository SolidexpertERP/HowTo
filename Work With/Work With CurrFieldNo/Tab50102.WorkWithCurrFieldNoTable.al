table 50102 "Work With CurrFieldNo Table"
{
    Caption = 'Work With CurrFieldNo Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Name"; Text[20])
        {
            Caption = 'User Name';
            DataClassification = ToBeClassified;
        }
        field(2; "User Surname"; Text[50])
        {
            Caption = 'User Surname';
            DataClassification = ToBeClassified;
        }
        field(3; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Message(StrSubstNo('CurrFieldNo %1', CurrFieldNo));
            end;
        }
        field(4; Age2; Integer)
        {
            Caption = 'Age 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.Validate(Age, Age2);
            end;
        }
    }
    keys
    {
        key(PK; "User Name")
        {
            Clustered = true;
        }
    }
}
