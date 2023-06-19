table 50103 "Data To Create Document"
{
    Caption = 'Data To Create Document';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Document No."; Code[100])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Ship-to Name"; Code[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Name 2"; Code[80])
        {
            Caption = 'Surname';
            DataClassification = ToBeClassified;
        }
        field(4; Address; Code[80])
        {
            Caption = 'Street';
            DataClassification = ToBeClassified;
        }
        field(5; City; Code[50])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
}
