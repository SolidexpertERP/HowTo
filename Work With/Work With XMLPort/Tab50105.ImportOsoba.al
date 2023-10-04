table 50105 "Import Osoba"
{
    Caption = 'Import Osoba';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Imie"; Text[250])
        {
            Caption = 'Imię';
        }
        field(2; "Nazwisko"; Text[250])
        {
            Caption = 'Nazwisko';
        }
        field(3; "Wiek"; Integer)
        {
            Caption = 'Wiek';

            trigger OnValidate()
            begin
                Message(Rec.Imie);
            end;
        }
        field(4; "Data Urodzenia"; Date)
        {
            Caption = 'Data Urodzenia';
        }
        field(5; "Miejsce Zamieszkania"; Text[250])
        {
            Caption = 'Miejsce Zamieszkania';
        }
    }
}
