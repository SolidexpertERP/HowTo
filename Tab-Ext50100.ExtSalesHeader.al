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
        field(50101; "My Field Test"; Text[100])
        {
            Caption = 'My Comunicat Field';
            DataClassification = ToBeClassified;
        }
        field(50102; "My Field Test 2"; Text[100])
        {
            Caption = 'My Comunicat Field 2';
            DataClassification = ToBeClassified;
        }
        field(50103; "Sales Header Counter"; Decimal)
        {
            Caption = 'Sales Header Counter';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("Sales Line".Amount where("Document Type" = const(Order)));
        }
    }

    trigger OnModify()
    var
        WorkWithRecord: Codeunit "Work With Record";
    begin
        //WorkWithRecord.HowWorkVariableWithVar(Rec);
        //WorkWithRecord.CompareRecord(Rec);
        //Message(Rec."My Field Test");

    end;
}
