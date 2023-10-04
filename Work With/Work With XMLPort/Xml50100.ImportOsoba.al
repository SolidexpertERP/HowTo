xmlport 50100 "Import Osoba"
{
    Caption = 'Import Osoba';
    UseRequestPage = false;
    FieldDelimiter = '';
    FieldSeparator = '|';
    RecordSeparator = '<CR>';
    Format = VariableText;


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ImportOsoba; "Import Osoba")
            {
                fieldelement(Field01; ImportOsoba.Imie) { }
                fieldelement(Field02; ImportOsoba.Nazwisko) { }
                fieldelement(Field03; ImportOsoba.Wiek)
                {
                    trigger OnBeforePassField()
                    begin
                        Message('');
                    end;
                }
                fieldelement(Field04; ImportOsoba."Data Urodzenia") { }
                fieldelement(Field05; ImportOsoba."Miejsce Zamieszkania") { }

                trigger OnBeforeInsertRecord()
                begin
                    Message(ImportOsoba.Imie);
                end;
            }

            trigger OnBeforePassVariable()
            begin
                Message(ImportOsoba.Imie);
            end;
        }
    }
}
