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
                    DialogTxt: Label 'Working... #1####### \ @2@@@@@@@';
                    Sum: Decimal;
                    Window: Dialog;
                    i: Integer;
                begin
                    Window.Open(DialogTxt);

                    // Jakaś pętla żeby chwilę trwało i coś pokazywało
                    for i := 1 To 5000 Do begin
                        if SomeTable.FindSet() then
                            repeat
                                Sum += SomeTable."Debit Amount";
                            until SomeTable.Next() = 0;

                        Window.Update(1, Sum);
                    end;
                end;
            }
        }
    }
}
