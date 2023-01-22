/// <summary>
/// Codeunit odpowiedzialny za zbudowanie treści maila
/// </summary>
codeunit 50121 "E-mail Builder" implements IBuilder
{
    var
        DataTypeMgt: Codeunit "Data Type Management";

    procedure CreateNotyfication(RecRef: RecordRef): Text
    var
        TxtNotyf: Text;
    begin
        TxtNotyf += CreateHeader();
        TxtNotyf += GetDocNo(RecRef);
        TxtNotyf += CreateBody();
        TxtNotyf += CreateFooter();

        exit(TxtNotyf);
    end;

    procedure CreateHeader(): Text
    begin
        exit('E-Mail Send:');
    end;

    procedure CreateBody(): Text
    begin
        exit('Body Email');
    end;

    procedure CreateFooter(): Text
    begin
        exit('Footer Email');
    end;

    local procedure GetDocNo(RecRef: RecordRef): Text
    var
        FRef: FieldRef;
    begin
        if DataTypeMgt.FindFieldByName(RecRef, FRef, 'No.') then
            exit(FRef.Value);
    end;
}
