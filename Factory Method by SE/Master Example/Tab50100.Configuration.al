table 50100 Configuration
{
    Caption = 'Configuration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));

            trigger OnLookup()
            begin
                ConfigValidateMgt.LookupTable("Table ID");
                if "Table ID" <> 0 then
                    Validate("Table ID");
            end;

            trigger OnValidate()
            begin
                if ConfigMgt.IsSystemTable("Table ID") then
                    Error(Text001, "Table ID");

                Rec."Table Name" := SetName(Rec."Table ID", AllObj."Object Type"::Table);
            end;
        }
        field(2; "Table Name"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = CONST(Table),
                                                                        "Object ID" = FIELD("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Type Notification"; Enum "Type Notyfication")
        {
            Caption = 'Type Notification';
        }
    }
    keys
    {
        key(PK; "Table ID")
        {
            Clustered = true;
        }
    }

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        AllObj: Record AllObj;


        Text001: Label 'You cannot use system table %1 in the package.';

    local procedure LookupCodeunit(var CodeunitID: Integer)
    var
        AllObj: Record AllObj;
    begin
        LookupObject(AllObj."Object Type"::Codeunit, CodeunitID);
    end;

    local procedure LookupObject(ObjectType: Integer; var ObjectID: Integer)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        Objects: Page Objects;
    begin
        Clear(Objects);
        AllObjWithCaption.FilterGroup(2);
        AllObjWithCaption.SetRange("Object Type", ObjectType);
        AllObjWithCaption.SetFilter("Object ID", '>%1', 50000);
        AllObjWithCaption.FilterGroup(0);
        Objects.SetTableView(AllObjWithCaption);
        Objects.LookupMode := true;
        if Objects.RunModal() = ACTION::LookupOK then begin
            Objects.GetRecord(AllObjWithCaption);
            ObjectID := AllObjWithCaption."Object ID";
        end;
    end;

    local procedure SetName(ObjectID: Integer; ObjectType: Option): Text[250]
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.SetRange("Object ID", ObjectID);
        AllObjWithCaption.SetRange("Object Type", ObjectType);
        AllObjWithCaption.FindFirst();
        exit(AllObjWithCaption."Object Name");
    end;
}
