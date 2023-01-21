/// <summary>
/// Codeunit w którym implementujemy zapis pliku do WORD
/// Implementuje on interface który wymusza na nas zaimplementowanie funkcji Save, ale możemy ro zrobić w dowolny sposób
/// </summary>
codeunit 50105 "Save Invoice To Word" implements "IInvoice Saver"
{

    procedure Save(SalesInvoice: Record "Sales Header")
    begin
        SaveDocumentAsWord(SalesInvoice);
    end;

    local procedure SaveDocumentAsWord(SInv: Record "Sales Header")
    begin
        Message('Hello This is individual procedure implemented save %1 to WORD', SInv."No.");
    end;

}
