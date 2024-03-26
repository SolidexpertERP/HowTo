codeunit 50143 "Web Services"
{
    /// <summary>
    /// Pobieranie pliku kursu wymiany walut CSV z serwera mBank, z linku podanego przez mBank, standardowe kliknięcie w link spowoduje automatyczne pobranie pliku
    /// </summary>
    procedure DownloadMBankCurrencyRate()
    var
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        FileUrl: Label 'https://www.mbank.pl/ajax/currency/getCSV/?id=0';
        TempBlob: Codeunit "Temp Blob";
        InputInStr: InStream;
        OutStr: OutStream;
        Response: Text;
        JObject: JsonObject;
        InStr: InStream;
        Txt: Text;
    begin
        HttpClient.Get(FileUrl, HttpResponse);

        if HttpResponse.IsSuccessStatusCode then begin
            TempBlob.CreateOutStream(OutStr);
            TempBlob.CreateInStream(InputInStr);
            HttpResponse.Content.ReadAs(InputInStr);
            CopyStream(OutStr, InputInStr);
            if TempBlob.HasValue() then begin
                InStr := TempBlob.CreateInStream(TextEncoding::UTF8);
                InStr.ReadText(Txt);
                Message(Txt);
            end;
        end else begin
            HttpResponse.Content.ReadAs(Response);
            JObject.ReadFrom(Response);
            Error(Response);
        end;
    end;
}
