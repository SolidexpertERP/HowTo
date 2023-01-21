/// <summary>
/// Interfejs dzięki któremu będziemy mogli przekazać implementację Save w postaci dowolnego Codeunit który będzie implementował ten interfejs
/// </summary>
interface "IInvoice Saver"
{
    procedure Save(SalesInvoice: Record "Sales Header");
}
