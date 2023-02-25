codeunit 50132 "Work With Split Text"
{
    procedure SplitText()
    var
        Txt: Text[250];
        ListSplitTxt: List of [Text];
        LineNo: Integer;
    begin
        Txt := 'Text do podzielenia           ';
        ListSplitTxt := Txt.Split(' ');
        if not Evaluate(LineNo, ListSplitTxt.Get(5)) then
            LineNo := 0;
    end;
}
