/// <summary>
/// Codeunit odpowiedzialny za wysyłanie dokumentu. Jest to codeunit wysokopoziomowy który przed wysyłką sprawdza czy dokument nadaje się do wysyłki 
/// i wysyła go. Dzięki takiemu podejściu, nasz codeunit uniezależniony jest od różnych implementacji wysyłki.
/// </summary>
codeunit 50109 "Document Sender"
{
    var
        Notyfication: Interface INotyfication;

    /// <summary>
    /// Dependency injection - wstrzyknięcie zależności poprzez interfejs, czyli sposoby wysyłki dokumentu SMS lub E-mail, których możemy deklarować wiele
    /// Codeunit wysyłający "Document Sender" zawsze działa tak samo, sprawdza przed wysyłką dowolne wartości i wysyła w taki sposób jaki mu podamy.
    /// </summary>
    procedure SetINotyfication(INotyf: Interface INotyfication)
    begin
        Notyfication := INotyf;
    end;

    procedure SendDocumentNotyfication(Document: Variant)
    begin
        if CheckDocument(Document) then
            Notyfication.SendNotyfication(Document);
    end;

    local procedure CheckDocument(Document: Variant): Boolean
    begin
        if not Document.IsRecord then
            Message('I cant send docuemnt becoause docuemnt is Empty!');

        exit(Document.IsRecord);
    end;
}
