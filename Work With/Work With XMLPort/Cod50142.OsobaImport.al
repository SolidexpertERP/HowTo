codeunit 50142 "Osoba Import"
{
    procedure ImportCSV()
    var
        FileMgt: Codeunit "File Management";
        InStr: InStream;
        TabelaOsoba: Record "Import Osoba";
        PortXML: XmlPort "Import Osoba";
        TempBlob: Codeunit "Temp Blob";
    begin
        FileMgt.BLOBImport(TempBlob, 'PrzykladowyPlikCSV');
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        PortXML.SetTableView(TabelaOsoba);
        PortXML.SetSource(InStr);
        PortXML.Import();
    end;
}
