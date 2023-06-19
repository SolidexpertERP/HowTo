codeunit 50125 "SMS Message Builder" implements IBuilderNotyfication
{
    procedure CreateMessage(RecRef: RecordRef) Message: Text;
    begin
        exit('This is simple SMS text message');
    end;
}
