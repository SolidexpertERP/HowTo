table 50104 "UV KPI Items"
{
    Caption = 'UV KPI Items';
    DataClassification = ToBeClassified;
    LinkedObject = true;
    TableType = Temporary;


    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
