page 50101 "Work With User Dialog"
{
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Work With User Dialog';
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowDialog)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SomeTable: Record "G/L Entry";
                    DialogTxt: Label 'Working... Nr: #1##### wiersza \Procent: @2@@@@@'; // # - deklaracja pola / @ - progressbar gdzie 10000 to 100%
                    Nr: Integer;
                    Procent: Decimal;
                    Window: Dialog;
                    i: Integer;
                begin
                    Window.Open(DialogTxt, Nr, Procent);

                    // Jakaś pętla żeby chwilę trwało i coś pokazywało
                    for i := 1 To 15 Do begin
                        Nr := i;
                        Procent := Round((10000 / 15) * i, 1, '=');

                        Window.Update(); // Opcja Update 1 - jeżeli przekażemy w Window.Open zmienne, to wystarczy Update i zostaną one zaktualizowane

                        Window.Update(1, Nr); // Opcja Update 2 - jeżeli nie mamy w Window zmiennych to aktualizujemy po kolei
                        Window.Update(2, Procent);

                        Sleep(200);
                    end;

                    Sleep(400);
                    Window.Close();
                end;
            }
        }
    }
}
