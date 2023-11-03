page 50109 "Interface Example"
{
    ApplicationArea = All;
    Caption = 'Interface Example';
    PageType = Card;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Interface Type"; NotyficationOption)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Test Interface")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    INotyficationCreator: interface "INotyfication Creator";
                    Document: Variant;
                begin
                    INotyficationCreator := NotyficationOption;
                    if INotyficationCreator.CheckDocument(Document) then begin
                        Message(INotyficationCreator.CreateMessage());
                    end;
                end;
            }
        }
    }

    var
        NotyficationOption: Enum "Notyfication Option";
}
