enum 50101 "Type Notyfication" implements INotification, IBuilderNotyfication
{
    Extensible = true;

    value(0; "SMS")
    {
        Caption = 'SMS';
        Implementation = INotification = "SMS Notification", IBuilderNotyfication = "SMS Message Builder";
    }
    value(1; "E-mail")
    {
        Caption = 'E-mail';
        Implementation = INotification = "E-mail Notification", IBuilderNotyfication = "E-mail Message Builder";

    }

}
