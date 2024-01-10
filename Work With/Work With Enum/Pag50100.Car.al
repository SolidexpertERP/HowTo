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
                field("Show Enum Integer"; CarType)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetEnumIntegerValue(CarType);
                    end;
                }
                field("Show Enum Ordinals"; CarType)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetEnumOrdinalsValue(CarType);
                    end;
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

    /// <summary>
    /// Pobranie wartości integer z enum np.  value(1; "S") => pobranie 1
    /// </summary>
    /// <param name="CarType"></param>
    local procedure GetEnumIntegerValue(CarType: Enum "Type Of Car")
    begin
        Message(Format(CarType.AsInteger()));
    end;

    /// <summary>
    /// Pobranie wartości Ordinals z enum np.  value(1; "S") => pobranie "S"
    /// </summary>
    /// <param name="CarType"></param>
    local procedure GetEnumOrdinalsValue(CarType: Enum "Type Of Car")
    var
        Index: Integer;
        ValueName: Text;
    begin
        Index := CarType.Ordinals().IndexOf(CarType.AsInteger());
        CarType.Names().Get(Index, ValueName);
        Message(ValueName);
    end;
}
