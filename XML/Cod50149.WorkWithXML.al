codeunit 50149 "Work With XML"
{

    /// <summary>
    /// Procedura mająca na celu utworzyć przykładowego XML'a przy użyciu XML portu i zapisanie go na dysku
    /// </summary>
    /// <param name="SalesHdr"></param>
    procedure CreateSampleXML(SalesHdr: Record "Sales Header")
    begin
        CreateSampleXMLWithXMLPort(SalesHdr);
        CreateSampleXMLSimpleMethod(SalesHdr);
    end;

    /// <summary>
    /// Funkcja do genrowania XML'a przy pomocy XMLPort na którym zapisana jest cała logika i sposób tworzenia XML'a
    /// Dodatkowo funkcja napisana jest w taki sposób aby po wciśnięciu przycisku na Page plik od razu zapisał się na dysku, aby nie pokazywały się żadne dodatkowe parametry
    /// </summary>
    /// <param name="SalesHdr"></param>
    local procedure CreateSampleXMLWithXMLPort(SalesHdr: Record "Sales Header")
    var
        XMLPort: XmlPort "XML Port 1";
        OutStrm: OutStream;
    begin
        TempBlob.CreateOutStream(OutStrm);
        XMLPort.SetTestVar('1234566');
        XMLPort.SetTableView(SalesHdr);
        XMLPort.SetDestination(OutStrm);
        XMLPort.Export();
        SaveFileToDisc();
    end;

    /// <summary>
    /// Funckja do tworzenia XML'a w sposób ręczny krok po kroku, bez żadnego szablonu w postaci XMLPort'a
    /// </summary>
    /// <param name="SalesHdr"></param>
    local procedure CreateSampleXMLSimpleMethod(SalesHdr: Record "Sales Header")
    begin

    end;

    procedure ImportSampleXML()
    begin
        ImportSubmitOrderResponse();
    end;

    local procedure ImportSubmitOrderResponse()
    var
        InStr: InStream;
        XmlDoc: XmlDocument;
    begin
        if UploadIntoStream('Import SubmitOrderResponse JD', InStr) then
            XmlDocument.ReadFrom(InStr, XmlDoc)
        else
            Error('Błąd wczytywania pliku XML');

    end;

    procedure SaveFileToDisc()
    var
        InStr: InStream;
        FileName: Text;
    begin
        FileName := 'Test.xml';
        TempBlob.CreateInStream(InStr, TextEncoding::UTF8);
        DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure ImportCurrencyRate()
    var
        BEMultiBankCurrencyRates: Record "BE MultiBank Currency Rates";
        XMLMultiBankCurrencyRates: XmlPort "BE MultiBank Currency Rates";
        JObject: JsonObject;
        InStr: InStream;
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        FileUrl: Label 'https://www.mbank.pl/ajax/currency/getCSV/?id=0';
        Response: Text;
    begin
        HttpClient.Get(FileUrl, HttpResponse);
        if HttpResponse.IsSuccessStatusCode then begin
            HttpResponse.Content.ReadAs(InStr);
            BEMultiBankCurrencyRates.DeleteAll();
            XMLMultiBankCurrencyRates.SetTableView(BEMultiBankCurrencyRates);
            XMLMultiBankCurrencyRates.SetSource(InStr);
            XMLMultiBankCurrencyRates.Import();
            Page.Run(Page::"BE MultiBank Currency Rates", BEMultiBankCurrencyRates);
        end else begin
            HttpResponse.Content.ReadAs(Response);
            JObject.ReadFrom(Response);
            Error(Response);
        end;
    end;


    var
        TempBlob: Codeunit "Temp Blob";
}
