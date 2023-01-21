codeunit 50107 "HP Printer" implements IFax, IScan
{

    procedure Fax(Document: Variant)
    begin
        Message('HP Printer FAX Document...');
    end;

    procedure Scan(Document: Variant);
    begin
        Message('HP Printer SCAN Document...');
    end;
}
