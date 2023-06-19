page 50103 "Configuration by SE"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Configuration by SE';
    PageType = List;
    SourceTable = Configuration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Table Name field.';
                }
                field("Type Notification"; Rec."Type Notification")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
