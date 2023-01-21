/// <summary>
/// Codeunit w którym implementujemy zapis pliku do PDF
/// Implementuje on interface który wymusza na nas zaimplementowanie funkcji Save
/// Implementacja interfejsu powoduje, że w późniejszym kroku będziemy pracować na interfejsie pod którym w zależności od wymaganej sytuajci będą znajdować się 
/// różne implemntacje metody Save
/// </summary>
codeunit 50104 "Save Invoice To PDF" implements "IInvoice Saver"
{

    procedure Save(SalesInvoice: Record "Sales Header")
    begin
        SaveDocumentAsPDF(SalesInvoice);
    end;

    local procedure SaveDocumentAsPDF(SInv: Record "Sales Header")
    begin
        Message('Hello This is individual procedure implemented save %1 to PDF', SInv."No.");
    end;

}
