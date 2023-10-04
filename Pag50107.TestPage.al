page 50107 "Test Page"
{
    ApplicationArea = All;
    Caption = 'Test Page';
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Filtr LineNo = 10*")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    WorkWith: Codeunit "Work With Record";
                    PurchLine: Record "Purchase Line";
                begin
                    WorkWith.LineNoFilter(PurchLine);
                    Message('Line No: %1, No.: %2', PurchLine."Line No.", PurchLine."No.");
                end;
            }
        }
    }
}
