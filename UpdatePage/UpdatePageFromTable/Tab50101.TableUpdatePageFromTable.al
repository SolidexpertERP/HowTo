table 50101 "Table Update Page From Table"
{
    Caption = 'Table Update Page From Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Field A"; Text[100])
        {
            Caption = 'Field A';
            DataClassification = ToBeClassified;
        }
        field(2; "Field B"; Text[100])
        {
            Caption = 'Field B';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                Selection: Integer;
                CU: Codeunit "Update Page From Table";
            begin
                Selection := StrMenu('Wór A,Wybór B', 1);
                case Selection of
                    1:
                        begin
                            Rec."Field A" := 'Wór';
                            Rec."Field B" := 'A';
                        end;
                    2:
                        begin
                            Rec."Field A" := 'Wybór';
                            Rec."Field B" := 'B';
                        end;
                end;

                //OnAfterSetField();
                CU.RunUpdatePage();
            end;
        }
        field(3; No; Integer)
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; No)
        {

        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetField()
    begin
    end;
}
