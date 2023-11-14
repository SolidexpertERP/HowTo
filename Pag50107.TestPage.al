page 50107 "Test Page"
{
    ApplicationArea = All;
    Caption = 'Test Page';
    PageType = Card;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Group General Normal Widh';

                field(Field001; Field001)
                {
                    ApplicationArea = All;
                    Caption = 'Field001';

                    trigger OnValidate()
                    var
                        Label: Label '';
                    begin
                        LabelCaptionTxt := Field001.Replace('AS', Label);
                    end;
                }
                label(MyLabel)
                {
                    CaptionClass = LabelCaptionTxt;
                    ApplicationArea = All;
                }
            }
            cuegroup("Wide Group")
            {
                Caption = 'Wide Group';

                field(Field002; 1)
                {
                    ApplicationArea = All;
                    Caption = 'Pole obrazkowe 1';
                    Image = Cash;

                    trigger OnDrillDown()
                    var
                        SalesHdr: Record "Sales Header";
                    begin
                        SalesHdr.FindFirst();
                        Page.Run(Page::"Sales Order", SalesHdr);
                    end;

                }
                field(Field003; 2)
                {
                    ApplicationArea = All;
                    Caption = 'Pole obrazkowe 2';
                    Image = Heart;
                }
                field(Field004; 3)
                {
                    ApplicationArea = All;
                    Caption = 'Pole obrazkowe 3';
                    Image = Chart;
                }
                field(Field005; 10)
                {
                    ApplicationArea = All;
                    Caption = 'Pole obrazkowe 4';
                    Image = Folder;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Ad Hock Function")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit JSON;
                begin
                    WorkWith.CreateJSON2();
                end;
            }

            action("Ad Hock Function 2")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "My Codeunit Managament";
                begin
                    WorkWith.ProcedureWithOptionalParam('My Text 0', 0, true); // Message = "Sales Header"
                    WorkWith.ProcedureWithOptionalParam('My Text 1', 1, true); // Message = "Purchase Header"
                end;
            }
        }
    }



    var
        Field001: Text[50];
        LabelCaptionTxt: Text;
}
