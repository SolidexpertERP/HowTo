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
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                    Editable = false;
                    Caption = 'Ilość odświeżeń strony';
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

    actions
    {
        area(Processing)
        {
            action(ShowPopUp)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.UpdatePage.ShowPopUp();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Result += 1;
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
    Images = 'UpdatePage/UpdatePageFromTable/car2.jpg';

    RequestedHeight = 400;
    MinimumHeight = 400;
    MaximumHeight = 400;
    RequestedWidth = 400;
    MinimumWidth = 400;
    MaximumWidth = 400;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    event ControlAddInReady();
    event UpdateMyPage();
    event ReturnFromJS(Txt: Text);
    procedure CallToJS(Msg: Text);
    procedure ShowPopUp();
}
