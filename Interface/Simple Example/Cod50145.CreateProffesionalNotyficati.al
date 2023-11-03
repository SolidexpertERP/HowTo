codeunit 50145 "Create Proffesional Notyficati" implements "INotyfication Creator"
{
    procedure CheckDocument(Document: Variant): Boolean;
    begin
        exit(Dialog.Confirm('Czy chcesz pójść dalej?'));
    end;

    procedure CreateMessage(): Text;
    begin
        exit('Proffesional Notyfication!');
    end;
}
