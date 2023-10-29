page 50108 "Java Script"
{
    ApplicationArea = All;
    Caption = 'Java Script';
    PageType = Card;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Item; ItemNo)
                {
                    ApplicationArea = All;
                    TableRelation = Item;

                    trigger OnValidate()
                    begin
                        CurrPage.MyJS.ShowPopUp();
                    end;
                }
                field("Id Element"; IdElement)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.MyJS.SetFocusOnField(IdElement);
                    end;
                }
                field("My Text"; MyText)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.MyJS.SetFocusOnField(MyText);
                    end;
                }
                field("My Text 2"; MyText2)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.MyJS.SetFocusOnField(MyText2);
                    end;
                }
            }
            usercontrol(MyJS; MyJSControl)
            {
                ApplicationArea = all;
                Visible = true;

                trigger Ready()
                begin
                    CurrPage.MyJS.SetFocusOnField('My Text 2');
                end;
            }
        }
    }

    var
        ItemNo: Code[20];
        IdElement: text;
        MyText: text;
        MyText2: text;
}

controladdin MyJSControl
{
    Scripts = 'JavaScript\jscript.js';

    RequestedHeight = 1;
    MinimumHeight = 1;
    MaximumHeight = 1;
    RequestedWidth = 1;
    MinimumWidth = 1;
    MaximumWidth = 1;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    event Ready();
    procedure ShowPopUp();
    procedure SetFocusOnField(fieldNo: Text);
}
