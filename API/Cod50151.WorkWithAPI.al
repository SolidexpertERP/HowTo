codeunit 50151 "Work With API"
{
    /// <summary>
    /// Procedura wysyłania SMS'ów przez smsapi.pl
    /// </summary>
    procedure APISMS()
    var
        URL: Text;
        Body: Text;
        Content: HttpContent;
        Http: HttpClient;
        HttpHdr: HttpHeaders;
        Json: JsonObject;
        Response: HttpResponseMessage;
        ResponseMessage: Text;
    begin
        HttpHdr := Http.DefaultRequestHeaders();
        HttpHdr.Add('Authorization', 'Bearer fwRn9iHf8hFL1OvqJ61WKWCuLd5PPuEjlBEnqrwK=');

        Json.Add('message', 'Czesc to ja Karolek z BC');
        Json.Add('to', '503415528');
        Json.WriteTo(Body);

        Content.WriteFrom(Body);
        Content.GetHeaders(HttpHdr); // HttpContent zawiera domyślny nagłówek 'Content-Type' o wartości 'text/plain; charset=utf-8', trzeba go zamienić bo przekazujemy Body jako .json
        HttpHdr.Remove('Content-Type');
        HttpHdr.Add('Content-Type', 'application/json');

        URL := 'https://api.smsapi.pl/sms.do';

        Http.Post(URL, Content, Response);

        if Response.IsSuccessStatusCode then
            Message('Code: %1', Response.HttpStatusCode);

        Response.Content.ReadAs(ResponseMessage);
        Message(ResponseMessage);
    end;
}
