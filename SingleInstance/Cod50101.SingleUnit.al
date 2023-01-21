/// <summary>
/// Codeunit, który ma jedno wystąpienie w całej aplikacji "SingleInstance = true" per firma. Cykl życia trwa do momentu zmiany firmy.
/// Dzięki niemu, można odbierać informację pomiędzy dokumentami. 
/// </summary>

codeunit 50101 "Single Unit"
{
    SingleInstance = true;

    trigger OnRun()
    begin
        Txt := 'Init';
    end;

    procedure SetTxt(Value: Text)
    begin
        Txt := Value;
    end;

    procedure GetTxt(var _Txt: Text)
    begin
        _Txt := Txt;
    end;

    procedure ShowTxt()
    begin
        Message(Txt);
    end;

    var
        Txt: Text;

    [EventSubscriber(ObjectType::Page, Page::Car, 'OnOpenPageEvent', '', false, false)]
    local procedure SetCarInit()
    begin
        SetTxt('Page::Car - OnOpenPageEvent');
    end;

    [EventSubscriber(ObjectType::Page, Page::Car, 'OnQueryClosePageEvent', '', false, false)]
    local procedure OnQueryClosePageEvent()
    var
        Txt001: Text;
    begin
        GetTxt(Txt001);
        Message('OnQueryClosePageEvent: ' + Txt001);
    end;
}
