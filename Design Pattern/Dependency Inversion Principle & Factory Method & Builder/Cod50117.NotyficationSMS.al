/// <summary>
/// Codeunit odpowiedzialny za wysyłanie wiadomości SMS w postaci tekstu. Przyjmuje tekst a cała reszta powinna być tutaj zaimplementowana.
/// </summary>
codeunit 50117 "Notyfication SMS" implements INotyfictions
{

    procedure SendNotyf(Document: Variant; Body: Text)
    begin
        Message('SMS Notyfication %1', Body);
    end;

}
