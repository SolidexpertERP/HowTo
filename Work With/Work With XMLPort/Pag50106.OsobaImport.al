page 50106 "Osoba Import"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Osoba Import';
    PageType = List;
    SourceTable = "Import Osoba";


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Imie; Rec.Imie)
                {
                    ApplicationArea = All;
                }
                field(Nazwisko; Rec.Nazwisko)
                {
                    ApplicationArea = All;
                }
                field("Data Urodzenia"; Rec."Data Urodzenia")
                {
                    ApplicationArea = All;
                }
                field("Miejsce Zamieszkania"; Rec."Miejsce Zamieszkania")
                {
                    ApplicationArea = All;
                }
                field(Wiek; Rec.Wiek)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action(ImportCSV)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CUImport: Codeunit "Osoba Import";
                begin
                    CUImport.ImportCSV();
                end;
            }
            action("Export Permissio Set")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Xmlport.Run(50101, false, false);
                end;
            }
            action("Export Sales Header to CSV")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Xmlport.Run(50102, false, false);
                end;
            }
        }
    }
}
