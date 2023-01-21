codeunit 50108 "Brother Printer" implements IPrinter, IFax, IScan
{

    procedure PrintGrey(Document: Variant)
    begin
        Message('Brother Printer PrintGrey');
    end;

    procedure PrintColor(Document: Variant)
    begin
        Message('Brother Printer PrintGrey');
    end;

    procedure Fax(Document: Variant);
    begin
        Message('Brother Printer Fax');
    end;

    procedure Scan(Document: Variant);
    begin
        Message('Brother Printer Scan');
    end;
}
