/// <summary>
/// Coedunit odpowiedzialny za wysłanie treści maila. Tutaj powinna być implementacja wysyłki e-mail
/// </summary>
codeunit 50118 "E-mail Notyfication" implements INotyfictions
{

    procedure SendNotyf(Document: Variant; Body: Text)
    begin
        Message('E-Mail Notyfication %1', Body);
    end;

}
