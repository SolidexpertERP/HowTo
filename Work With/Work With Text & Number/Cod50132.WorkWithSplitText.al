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

    procedure FormatInteger()
    var
        LineNoTxt: Text;
        LineNo: Integer;
    begin

    end;

    procedure PadString()
    var
        Str1: Text;
        Str2: Text;
        Len1: Integer;
        Len2: Integer;
        Text000: Label '13 characters';
        Text001: Label 'Four';
        Text002: Label 'Before PADSTR is called:\';
        Text003: Label '>%1< has the length %2\';
        Text004: Label '>%3< has the length %4\';
        Text005: Label 'After PADSTR is called:\';
    begin
        Str1 := Text000;
        Str2 := Text001;
        Len1 := STRLEN(Str1);
        Len2 := STRLEN(Str2);
        MESSAGE(Text002 + Text003 + Text004, Str1, Len1, Str2, Len2);

        Str1 := PADSTR(Str1, 5); // Truncate the length to 5  
        Str2 := PADSTR(Str2, 15, 'w'); // Concatenate w until length = 15  
        Len1 := STRLEN(Str1);
        Len2 := STRLEN(Str2);
        MESSAGE(Text005 + Text003 + Text004, Str1, Len1, Str2, Len2);

        Str1 := Text000;
        Str1 := PadStr('', StrLen(Str1), '0'); // Zastąpnie całego Text000 "zerami"
        Message(Str1);
    end;
}
