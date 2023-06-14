page 50105 "Work With CurrFieldNo Page"
{
    ApplicationArea = All;
    Caption = 'Work With CurrFieldNo Page';
    PageType = Card;
    SourceTable = "Work With CurrFieldNo Table";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("User Surname"; Rec."User Surname")
                {
                    ToolTip = 'Specifies the value of the User Surname field.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field(Age2; Rec.Age2)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Test CurrFieldNo 1")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo1();
                end;
            }
            action("Test CurrFieldNo 2")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo2();
                end;
            }
            action("Test CurrFieldNo 3")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo3();
                end;
            }
            action("Test CurrFieldNo 4")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo4();
                end;
            }
            action("Test CurrFieldNo 5")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo5();
                end;
            }
            action("Test CurrFieldNo 6")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo6(Rec);
                end;
            }
            action("Test CurrFieldNo 7")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo7();
                end;
            }
            action("Test CurrFieldNo 8")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.TestCurrentFieldNo8(Rec);
                end;
            }
            action("Test CurrFieldNo 9 CU.Run")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Managament: Codeunit "Work With CurrFieldNo Codeunit";
                begin
                    Managament.Run(Rec);
                end;
            }
            action("Test CurrFieldNo 10 Rec")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Validate(Age);
                    Rec.Validate(Age, 10);
                    Rec.Validate(Age, Rec.Age2);
                    Rec.Validate(Age2);
                    Rec.Validate(Age2, 10);
                end;
            }
        }
    }
}
