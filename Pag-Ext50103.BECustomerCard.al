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
        }
    }
}
