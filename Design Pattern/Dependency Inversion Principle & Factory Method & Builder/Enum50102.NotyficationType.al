/// <summary>
/// Typy wysyłki wykorzystywane w fabryce
/// </summary>
enum 50102 "Notyfication Type"
{
    Extensible = true;

    value(0; "SMS")
    {
        Caption = 'SMS Notyfication';
    }
    value(1; "E-mail")
    {
        Caption = 'E-mail Notyfication';
    }
}
