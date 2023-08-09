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
}
