/// <summary>
/// Codeunit do zarządzania wysyłką, który podpinamy pod przycisk na dowolnym dokumencie. 
/// Obiekt wysokopoziomowy który wykorzystyje Fabrykę "Notyfication Factory" dzięki której dostarczane są do interfejsów implementacje odpowiednich Codeunit.
/// </summary>
codeunit 50120 "Notyfication Document"
{
    var
        NotyficationFactory: Codeunit "Notyfication Factory";
        DataTypeMgt: Codeunit "Data Type Management";
        INotyfication: Interface INotyfictions;
        IBuilder: Interface IBuilder;
        RecRef: RecordRef;
        Notyfication: Text;

    /// <summary>
    /// Główna procedura do zarządzania wysyłką powiadmomienia. Tutaj jest cała logiga biznesowa wysyłki powiadomienia. 
    /// </summary>
    /// <param name="Document"></param>
    /// <param name="NotyfType"></param>
    procedure SendDocument(Document: Variant; NotyfType: Enum "Notyfication Type")
    begin
        SetInterfaceImplementation(NotyfType);
        CheckDocument(Document);
        DataTypeMgt.GetRecordRef(Document, RecRef);
        Notyfication := CreateNotyfivation();
        INotyfication.SendNotyf(Document, Notyfication);
    end;

    /// <summary>
    /// Wstrzyknięcie zależności do Interfejsów. Wstrzykuje implementacje odpowiednich Codeunit do interfejsów
    /// </summary>
    /// <param name="NotyfType"></param>
    procedure SetInterfaceImplementation(NotyfType: Enum "Notyfication Type")
    begin
        INotyfication := NotyficationFactory.GetNotyfication(NotyfType);
        IBuilder := NotyficationFactory.GetBuilder(NotyfType);
    end;

    /// <summary>
    /// Przykładowa procedura do sprawdzania czy jako parametr przyszedł RecRef
    /// </summary>
    /// <param name="Document"></param>
    local procedure CheckDocument(Document: Variant)
    begin
        if not Document.IsRecord then
            Error('This is not a record Variable');
    end;

    /// <summary>
    /// Funkcja do tworzenia treści powiadomienia SMS lub E-mail lub innych w zależności od tego co zostało wstrzyknięte do interfejsu IBuilder
    /// </summary>
    /// <returns></returns>
    local procedure CreateNotyfivation() Notyf: Text
    begin
        Notyf := IBuilder.CreateNotyfication(RecRef);
        exit(Notyf);
    end;

}
