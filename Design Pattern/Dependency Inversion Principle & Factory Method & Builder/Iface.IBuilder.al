/// <summary>
/// Interfejs Budowania treści wiadomości
/// </summary>
interface IBuilder
{
    procedure CreateNotyfication(RecRef: RecordRef): Text;
}
