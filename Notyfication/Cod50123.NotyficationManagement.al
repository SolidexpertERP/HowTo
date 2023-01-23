codeunit 50123 "Notyfication Management"
{
    procedure MyFirstAction(Notyf: Notification)
    var
        Name: Text;
        Surname: Text;
    begin
        //  Odebranie argumentów
        Name := Notyf.GetData('Name');
        Surname := Notyf.GetData('Description');
        Message('MyFirstAction: Name: %1 %2', Name, Surname);
    end;

    procedure MySecondAction(Notyf: Notification)
    var
        Name: Text;
        Surname: Text;
    begin
        Name := Notyf.GetData('Name');
        Surname := Notyf.GetData('Description');
        Message('MySecondAction: Name: %1 %2', Name, Surname);
    end;

    procedure SimpleMessage(Notyf: Notification)
    var
        Name: Text;
        Surname: Text;
    begin
        Name := Notyf.GetData('Name');
        Surname := Notyf.GetData('Description');
        Message('SimpleMessage: Name: %1 %2', Name, Surname);
    end;
}
