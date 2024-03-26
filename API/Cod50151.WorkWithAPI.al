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
        HttpHdr.Add('Authorization', 'Bearer fwRn9iHf8hFL1OvqJ61WKWCuLd5PPuEjlBEnqrwK');

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
            Content := Response.Content
        else
            Error('Response failed: %1, %2', Response.HttpStatusCode, Response.ReasonPhrase);


        Response.Content.ReadAs(ResponseMessage);
        Message(ResponseMessage);
    end;

    procedure APISMS2()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Request: HttpRequestMessage;
        HttpHeader: HttpHeaders;
        Content: HttpContent;
        Json: JsonObject;
        Body: Text;
        ResponseMessage: Text;
    begin
        //  Przygotowanie JSON
        Json.Add('message', 'Czesc to ja Karolek z BC - Method2');
        Json.Add('to', '503415528');
        Json.WriteTo(Body);

        //  Obsłużenie Contentu czyli całej zawartości wysyłanego zapytania
        Content.WriteFrom(Body);
        Content.GetHeaders(HttpHeader);
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/json');

        //  Złożenie request i wysyłka
        Request.SetRequestUri('https://api.smsapi.pl/sms.do');
        Request.Method('POST');
        Request.GetHeaders(HttpHeader);
        HttpHeader.Add('Authorization', 'Bearer fwRn9iHf8hFL1OvqJ61WKWCuLd5PPuEjlBEnqrwK');
        Request.Content(Content);
        Client.Send(Request, Response);

        if Response.IsSuccessStatusCode then
            Content := Response.Content
        else
            Error('Response failed: %1, %2', Response.HttpStatusCode, Response.ReasonPhrase);

        Response.Content.ReadAs(ResponseMessage);
        Message(ResponseMessage);
    end;

    procedure SomeApi()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Request: HttpRequestMessage;
        URL: Text;
        Txt: Text;
        Txt2: Text;
    begin
        URL := 'https://jsonplaceholder.typicode.com/todos/3';

        // Method 1
        Client.Get(URL, Response);
        if Response.IsSuccessStatusCode then
            Content := Response.Content
        else
            Error('Response failed: %1, %2', Response.HttpStatusCode, Response.ReasonPhrase);
        Response.Content.ReadAs(Txt);
        Message(Txt);

        // Method 2
        Request.SetRequestUri(URL);
        Request.Method('GET');
        Client.Send(Request, Response);
        if Response.IsSuccessStatusCode then
            Content := Response.Content
        else
            Error('Response failed: %1, %2', Response.HttpStatusCode, Response.ReasonPhrase);
        Response.Content.ReadAs(Txt2);
        Message(Txt2);
    end;

    procedure WeatherAPI()
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Header: HttpHeaders;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Txt: Text;
    begin
        Request.SetRequestUri('http://api.weatherapi.com/v1/current.json?key=18095e1d6c3e4c7cb02191259241403&q=Rzeszów');
        Request.Method('GET');
        // Request.GetHeaders(Header);
        // Header.Add('key', '18095e1d6c3e4c7cb02191259241403');
        // Header.Add('q', 'Rzeszów');
        Client.Send(Request, Response);

        if Response.IsSuccessStatusCode then begin
            Content := Response.Content;
            Content.ReadAs(Txt);
            Message(Txt);
        end else begin
            Error('%1 %2', Response.HttpStatusCode, Response.ReasonPhrase);
        end;
    end;
}
