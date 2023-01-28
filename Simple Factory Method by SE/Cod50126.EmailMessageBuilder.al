codeunit 50126 "E-mail Message Builder" implements IBuilderNotyfication
{
    procedure CreateMessage(RecRef: RecordRef) Message: Text;
    begin
        EncodingRecRef(RecRef);

        Message += CreateHeader();
        Message += CreateBody();
        Message += CreateFooter();
    end;

    local procedure EncodingRecRef(RecRef: RecordRef)
    begin

    end;

    procedure CreateHeader(): Text
    begin
        exit('Header e-mail \');
    end;

    procedure CreateBody(): Text
    begin
        exit('Body e-mail \');
    end;

    local procedure CreateFooter(): Text
    begin
        exit('Footer e-mail');
    end;

    var
        DocumentNo: Code[20];
}
