codeunit 50141 "Work With Variable"
{
    procedure WorkWithVariant()
    var
        NewValue: Variant;
        MsgTxt: Code[20];
    begin
        GetNewValue(NewValue);
        MsgTxt := NewValue;
        Message(MsgTxt);
    end;

    procedure GetNewValue(var NewVal: Variant)
    begin
        NewVal := 'Ala ma kota...';
    end;

    procedure BreakAndExitWhile()
    var
        SimpleList: List of [Text];
        ElementList: Text;
    begin
        SimpleList.Add('Item 1');
        SimpleList.Add('Item 2');
        SimpleList.Add('Item 3');
        SimpleList.Add('Item 4');

        foreach ElementList in SimpleList do begin
            Message(ElementList);
            if ElementList = 'Item 4' then
                break; // Powoduje przerwanie pętli i przejście do wykonania kodu który znajduje się poniżej pętli
            if ElementList = 'Item 3' then
                exit; // Powoduje zakończenie i wyjście z funkcji, bez wykonania kodu poniżej pętli
        end;

        Message('Przerwało pętle ale wykonała się ostatnia linia funkcji');
    end;

    procedure SkipWhile()
    var
        SimpleList: List of [Text];
        ElementList: Text;
        NextStep: Integer;
    begin
        SimpleList.Add('Item 1');
        SimpleList.Add('Item 2');
        SimpleList.Add('Item 3');
        SimpleList.Add('Item 4');

        // Pętla po elementach listy, dzięki NextStep możemy sterować pominięciem/wykonaniem konkretnej części kodu i przejściem do następnego elemntu listy.
        // Ustawienie NextStep = 999 powoduje pominięcię całego kodu i przejście do kolejnego elementu listy
        foreach ElementList in SimpleList do begin
            NextStep := 0;

            if NextStep = 0 then begin
                Message('Next Step: %1', NextStep);
                NextStep := 1;
            end;

            if NextStep = 1 then begin
                Message('Next Step: %1', NextStep);
                NextStep := 2;
            end;

            if NextStep = 2 then begin
                Message('Next Step: %1', NextStep);
                NextStep := 999; // Pomijamy sobie wszystkie następne kroki
            end;

            if NextStep = 3 then begin
                Message('Next Step: %1', NextStep);
                NextStep := 1;
            end;

            if NextStep = 4 then begin
                Message('Next Step: %1', NextStep);
            end;
        end;
    end;

    procedure ReadObjectType()
    begin
        ReadObjTyp(ObjectType::Page, Page::"Sales Order");
    end;

    local procedure ReadObjTyp(ObjTyp: ObjectType; ObjectId: Integer)
    begin
        case ObjTyp of
            ObjectType::Codeunit:
                Message('Im %1', ObjTyp);
            ObjectType::Page:
                begin
                    Page.Run(ObjectId);
                end;
        end;
    end;
}
