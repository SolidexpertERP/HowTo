page 50102 "My Page Notyfication"
{
    ApplicationArea = All;
    Caption = 'My Page Notyfication';
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
            }
        }
    }

    trigger OnOpenPage()
    var
        UserInfo: Notification;
        Name: Label 'Vladimir';
        Description: Label 'Putin';
    begin
        //  Nagłówek 
        UserInfo.Message('To jest przykładowy tekst...');

        //  Akcja w której podajemy nazwę jaka ma się wyświetlić, Codeunit który chcemy uruchomić, nazwa procedury w codeunt
        UserInfo.AddAction('Akcja 1', Codeunit::"Notyfication Management", 'MyFirstAction');
        //  Przekazanie argumentu do funkcji. ,może być ich dowolna ilość 
        UserInfo.SetData('Name', Name);
        UserInfo.SetData('Description', Description);

        UserInfo.AddAction('Akcja 2', Codeunit::"Notyfication Management", 'MySecondAction');
        UserInfo.SetData('Name', Name);
        UserInfo.SetData('Description', Description);

        UserInfo.AddAction('Akcja 3', Codeunit::"Notyfication Management", 'SimpleMessage');
        UserInfo.SetData('Name', Name);
        UserInfo.SetData('Description', Description);
        UserInfo.Send();
    end;
}
