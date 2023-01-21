/// <summary>
/// Codeunit odpowiedzialny za zapisywanie faktury, przyjmuje on fakturę którą ma zapisać oraz interfejs w którym przekazywana jest implementacja w jaki sposób ma tego dokonać
/// CodeUnit posiada jedną odpowiedzialność zapisywania faktury
/// Wywołanie tego Codeunit znajduje się w Pag-Ext50100.ExtSalesInvoice
/// </summary>
codeunit 50106 "Invoice Saver"
{
    var
        SalesIncoice: Record "Sales Header";
        IInvoiceSaver: Interface "IInvoice Saver";

    /// <summary>
    /// Konstruktor, który napełnia nasze zmienne wykorzystywane w Codeunit, w konstruktorze jest również wstrzykiwana zależność 
    /// </summary>
    procedure CtorInvoiceSaver(SalInv: Record "Sales Header"; InvSaver: Interface "IInvoice Saver")
    begin
        SalesIncoice := SalInv;
        IInvoiceSaver := InvSaver;
    end;

    procedure Save()
    begin
        IInvoiceSaver.Save(SalesIncoice);
    end;

}
