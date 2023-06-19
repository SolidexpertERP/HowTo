codeunit 50128 "E-mail Notification" implements INotification
{
    procedure SendNotyfication(MessageToSend: Text);
    begin
        Message('Hello! I''m send E-mail notyfiaction: %1', MessageToSend);
    end;
}
