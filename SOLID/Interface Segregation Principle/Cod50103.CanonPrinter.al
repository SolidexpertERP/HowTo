codeunit 50103 "Canon Printer" implements IPrinter, IScan
{

    procedure PrintGrey(Document: Variant)
    begin
        if Document.IsRecord then
            PrintInGrey(Document);
    end;

    procedure PrintColor(Document: Variant)
    begin
        if Document.IsRecord then
            PrintInColor(Document);
    end;

    procedure Scan(Document: Variant);
    begin
        ScanDocument(Document);
    end;

    local procedure PrintInGrey(Document: Variant)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FRef: FieldRef;
        KRef: KeyRef;
    begin
        DataTypeMgt.GetRecordRef(Document, RecRef);
        KRef := RecRef.KeyIndex(1);
        FRef := KRef.FieldIndex(1);
        Message('Canon Printer Grey %1', FRef.Value);
    end;

    local procedure PrintInColor(Document: Variant)
    begin
        Message('Canon Printer Print Color this document');
    end;

    local procedure ScanDocument(Document: Variant)
    begin
        Message('Canon Printer Scan');
    end;
}
