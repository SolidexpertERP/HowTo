xmlport 50102 ExportToCSV
{
    Caption = 'Export To CSV';
    FieldSeparator = '';
    FieldDelimiter = '';
    Format = VariableText;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                fieldattribute(No; SalesHeader."No.")
                {
                    trigger OnBeforePassField()
                    begin
                        FieldSeparator := ' ';
                        FieldDelimiter := '';
                    end;
                }
                fieldattribute(DocType; SalesHeader."Document Type") { }
                fieldattribute(BillTo; SalesHeader."Bill-to Contact No.")
                {
                    trigger OnBeforePassField()
                    begin
                        if SalesHeader."Bill-to Contact No." = '' then
                            SalesHeader."Bill-to Contact No." := 'BRAK NR FV';
                    end;
                }
                fieldattribute(DocDate; SalesHeader."Document Date")
                {
                    trigger OnBeforePassField()
                    begin
                        FieldSeparator := '|';
                    end;
                }
                fieldattribute(RespCent; SalesHeader."Responsibility Center")
                {
                    trigger OnBeforePassField()
                    begin
                        FieldDelimiter := ';';
                    end;
                }
            }
        }
    }
}
