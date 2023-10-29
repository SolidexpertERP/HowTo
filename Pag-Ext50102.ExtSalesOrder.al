pageextension 50102 "Ext Sales Order" extends "Sales Order"
{

    layout
    {
        addlast(General)
        {
            field("Sales Header Counter"; Rec."Sales Header Counter")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(CopyDoc)
            {
                Caption = 'Copy doc';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ICreateDocument: Interface "ICreate Document";
                    CreateDoc: Codeunit "Create Document";
                    SalesHeader: Record "Sales Header";
                begin
                    ICreateDocument := CreateDoc;
                    SalesHeader := ICreateDocument.CreateDocument(Rec);
                    Message(SalesHeader."No.");
                end;
            }
        }
    }
}
