xmlport 50101 ExportPermissionSetToXML
{
    Format = xml;

    schema
    {
        textelement(PermissionSets)
        {
            tableElement(PSet; "Aggregate Permission Set")
            {
                SourceTableView = WHERE("App Name" = FILTER(<> ''));
                XmlName = 'PermissionSet';
                fieldattribute(RoleID; pset."Role ID") { }
                fieldattribute(RoleName; pset.Name) { }
                tableelement(P; "Tenant Permission")
                {
                    XmlName = 'Permission';
                    LinkTable = pset;
                    LinkFields = "Role ID" = FIELD("Role ID");

                    textelement(ObjectType)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Object Type";
                            ObjectType := format(int);
                        end;
                    }
                    textelement(ObjectID)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Object ID";
                            ObjectID := format(int);
                        end;
                    }
                    textelement(ReadPermission)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Read Permission";
                            ReadPermission := format(int);
                        end;
                    }
                    textelement(InsertPermission)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Insert Permission";
                            InsertPermission := format(int);
                        end;
                    }
                    textelement(ModifyPermission)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Modify Permission";
                            ModifyPermission := format(int);
                        end;
                    }
                    textelement(DeletePermission)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Delete Permission";
                            DeletePermission := format(int);
                        end;
                    }
                    textelement(ExecutePermission)
                    {
                        trigger onbeforePassvariable();
                        var
                            int: Integer;
                        begin
                            int := p."Execute Permission";
                            ExecutePermission := format(int);
                        end;
                    }
                    textelement(SecurityFilter)
                    {
                        trigger onbeforePassvariable();
                        begin
                            SecurityFilter := format(p."Security Filter");
                        end;
                    }
                }
            }
        }
    }
}
