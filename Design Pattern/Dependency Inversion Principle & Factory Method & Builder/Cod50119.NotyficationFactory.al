/// <summary>
/// Codeunit odpowiedzialny za wstrzykiwanie odpowiednich Coedunit do codeunit zarządzającego wysyłką "Notyfication Document"
/// </summary>
codeunit 50119 "Notyfication Factory"
{
    /// <summary>
    /// Fabryka do wstrzyknięcia sposoby wysyłki
    /// </summary>
    /// <param name="NotyfType"></param>
    /// <returns></returns>
    procedure GetNotyfication(NotyfType: Enum "Notyfication Type"): Interface INotyfictions
    var
        EmailNotyf: Codeunit "E-mail Notyfication";
        SMSNotyf: Codeunit "Notyfication SMS";
    begin
        case NotyfType of
            NotyfType::"E-mail":
                exit(EmailNotyf);
            NotyfType::SMS:
                exit(SMSNotyf);
            else
                Error('Notyfication not implemented');
        end;
    end;

    /// <summary>
    /// Fabryka do wstrzyknięcia Builder'a odpowiedzialnego za utworzenie treści wiadomości
    /// </summary>
    /// <param name="NotyfType"></param>
    /// <returns></returns>
    procedure GetBuilder(NotyfType: Enum "Notyfication Type"): Interface IBuilder
    var
        EmailBuilder: Codeunit "E-mail Builder";
        SMSBuilder: Codeunit "SMS Builder";
    begin
        case NotyfType of
            NotyfType::"E-mail":
                exit(EmailBuilder);
            NotyfType::SMS:
                exit(SMSBuilder);
            else
                Error('Notyfication not implemented');
        end;
    end;
}
