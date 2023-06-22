pageextension 50103 "BE Customer Card" extends "Customer Card"
{
    actions
    {
        addfirst(processing)
        {
            action("Update City")
            {
                trigger OnAction()
                var
                    WorkWithRecRefMgt: Codeunit "Work With RecRef FieldRef";
                    NewCity: Text;
                begin
                    NewCity := Rec."Address 2";
                    WorkWithRecRefMgt.UpdateCity(Rec, NewCity, Rec.FieldNo(City));
                end;
            }
            action("Create Document")
            {
                trigger OnAction()
                var
                    CreateDoc: Codeunit "Create Document Managament";
                begin
                    CreateDoc.CreateShippingDocument(Rec);
                end;
            }
            action("Create Copy Customer")
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    MyCU: Codeunit "My Codeunit Managament";
                begin
                    Message(Rec."Name 2");
                    MyCU.Run(Rec);
                    Message(Rec."Name 2");
                end;
            }
            action("Add Two")
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    A: Decimal;
                    B: Decimal;
                    Sum: Decimal;
                begin
                    A := 1;
                    B := -3;
                    Sum := A + B;
                    Message('%1+%2=%3', A, B, Sum);
                end;
            }
        }
    }
}
