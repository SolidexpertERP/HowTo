/// <summary>
/// Codeunit opdowiedzialny za utworzoenie treści SMSa
/// </summary>
codeunit 50122 "SMS Builder" implements IBuilder
{
    var
        DataTypeMgt: Codeunit "Data Type Management";

    procedure CreateNotyfication(RecRef: RecordRef): Text
    var
        TxtNotyf: Text;
    begin
        TxtNotyf += 'This is simple SMS: ';
        TxtNotyf += GetDocNo(RecRef);

        exit(TxtNotyf);
    end;

    local procedure GetDocNo(RecRef: RecordRef): Text
    var
        FRef: FieldRef;
    begin
        if DataTypeMgt.FindFieldByName(RecRef, FRef, 'No.') then
            exit(FRef.Value);
    end;

}
