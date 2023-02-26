codeunit 50133 "Update Page From Table"
{
    TableNo = "Table Update Page From Table";
    SingleInstance = true;

    var
        JSGlobal: ControlAddIn UpdatePage;

    procedure SetControlAddIn(JS: ControlAddIn UpdatePage)
    begin
        JSGlobal := JS;
    end;

    procedure RunUpdatePage()
    begin
        JSGlobal.CallToJS('Dzwonię z Codeunitu!!');
    end;

    internal procedure AddPhoto()
    begin
        JSGlobal.AddPhoto();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Table Update Page From Table", 'OnAfterSetField', '', false, false)]
    local procedure OnAfterSetField()
    begin
        RunUpdatePage();
    end;



}
