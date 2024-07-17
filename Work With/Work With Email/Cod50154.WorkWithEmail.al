codeunit 50154 "Work With Email"
{
    procedure SendEmail()
    var
        Message: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenerio: Enum "Email Scenario";
    begin
        Message.Create('pitrakarol@gmail.com', 'Temat', 'Cześć to jest treś maila');
        Email.Send(Message, EmailScenerio::Reminder);
        Email.Send(Message, EmailScenerio::"Sales Invoice");
    end;
}
