codeunit 50127 "SMS Notification" implements INotification
{
    procedure SendNotyfication(MessageToSend: Text);
    begin
        Message('Hello! I''m send SMS notyfiaction: %1', MessageToSend);
    end;
}
