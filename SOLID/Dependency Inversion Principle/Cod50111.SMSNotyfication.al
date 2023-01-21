codeunit 50111 "SMS Notyfication" implements INotyfication
{

    procedure SendNotyfication(Document: Variant)
    begin
        SendSMSNotyfication(Document);
    end;

    local procedure SendSMSNotyfication(Document: Variant)
    begin
        Message('Hello i send SMS notyfication!');
    end;

}
