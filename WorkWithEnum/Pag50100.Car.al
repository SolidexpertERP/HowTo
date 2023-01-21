page 50100 Car
{
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Car';
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Car Type"; CarType)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowSingleton)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Singleton: Codeunit "Single Unit";
                begin
                    Singleton.ShowTxt();
                end;
            }
        }
    }

    var
        CarType: Enum "Type Of Car";
}
