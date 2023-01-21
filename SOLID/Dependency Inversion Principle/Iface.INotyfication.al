/// <summary>
/// Interfejs dzięki któremu wstrzykniemy niskopoziomowy kod do naszej wysokopoziomowego Codeunit
/// Implementacja w Pag-Ext50100.ExtSalesInvoice
/// </summary>
interface INotyfication
{
    procedure SendNotyfication(Document: Variant);
}
