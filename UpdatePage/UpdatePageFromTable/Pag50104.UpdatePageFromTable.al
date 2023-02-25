page 50104 "Update Page From Table"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Update Page From Table';
    PageType = Card;
    SourceTable = "Table Update Page From Table";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Field A"; Rec."Field A")
                {
                    ApplicationArea = All;
                }
                field("Field B"; Rec."Field B")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CU: Codeunit "Update Page From Table";
                    begin
                        Message('Field B trigger OnValidate()');
                        CurrPage.Update();
                    end;
                }
                field("Result"; Result)
                {
                    ApplicationArea = All;
                }

                field("Field C"; FieldTxt)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UpdatePage.CallToJS(FieldTxt);
                    end;
                }

                usercontrol(UpdatePage; UpdatePage)
                {
                    ApplicationArea = all;
                    Visible = true;

                    trigger UpdateMyPage()
                    begin
                        CurrPage.Update();
                    end;

                    trigger ReturnFromJS(Txt: Text)
                    begin
                        Message('Msg back from JS: %1', Txt);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Message('OnAfterGetCurrRecord()');
        Result += 100;
        CU.SetControlAddIn(CurrPage.UpdatePage);
    end;

    var
        Result: Integer;
        FieldTxt: Text;
        CU: Codeunit "Update Page From Table";
}

controladdin UpdatePage
{
    Scripts = 'UpdatePage/UpdatePageFromTable/UpdatePage.js';
    StartupScript = 'UpdatePage/UpdatePageFromTable/UpdateMain.js';

    HorizontalShrink = true;
    HorizontalStretch = true;
    MinimumHeight = 100;
    MinimumWidth = 100;
    RequestedHeight = 100;
    RequestedWidth = 100;
    VerticalShrink = true;
    VerticalStretch = true;

    event ControlAddInReady();
    event UpdateMyPage();
    event ReturnFromJS(Txt: Text);
    procedure CallToJS(Msg: Text);
}
