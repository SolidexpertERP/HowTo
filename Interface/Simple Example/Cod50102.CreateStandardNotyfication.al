codeunit 50102 "Create Standard Notyfication" implements "INotyfication Creator"
{
    procedure CheckDocument(Document: Variant): Boolean;
    begin
        exit(true);
    end;

    procedure CreateMessage(): Text;
    begin
        exit('Hello jestem utworzony z Codeunit "Create Standard Notyfication"');
    end;
}
