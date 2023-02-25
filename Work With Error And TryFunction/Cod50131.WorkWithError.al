/// <summary>
/// Dzięki oznaczeniu funkcji jako TryFunction nie powodujemy przerwania wykonania kodu. Jeżeli funkcja DoSomething() wykonała się z błędem 
/// wykonywanie kodu zakończyło by sie na lini 14, a tak kod zostanie puszczony dalej i najpraw
/// </summary>
codeunit 50131 "Work With Error"
{
    TableNo = "Sales Header";

    var
        SalesHeader: Record "Sales Header";

    trigger OnRun()
    var
        ErrorTxt: Text;
        ErrorCode: Text;
    begin
        SalesHeader := Rec;

        SalesHeader."External Document No." := 'Przed';
        SalesHeader.Modify();

        ClearLastError();

        if not DoSomething() then begin
            ErrorTxt := GetLastErrorText();
            ErrorCode := GetLastErrorCode();
        end;

        SalesHeader."External Document No." += ' + Po';
        SalesHeader.Modify();

        Message('ErrorTxt: "%1", ErrorCode: "%2"', ErrorTxt, ErrorCode);
    end;

    [TryFunction]
    local procedure DoSomething()
    begin
        DoSomethingElse()
    end;

    local procedure DoSomethingElse()
    var
        SH: Record "Sales Header";
    begin
        SH := SalesHeader;

        SH."External Document No." += ' + Przed Błedem';
        SH.Modify();

        DoSomethingElseElse();

        SH."External Document No." += ' + Po Błędzie';
        SH.Modify();
    end;

    local procedure DoSomethingElseElse()
    begin
        Error('Procedure DoSomethingElseElse not implemented.');
    end;
}
