codeunit 50152 "OAuth 2.0"
{
    procedure OAuth()
    var
        Token: Text;
        URL: Text;
        HttpClient: HttpClient;
        HttpHeader: HttpHeaders;
        HttpContent: HttpContent;
        HttpRespone: HttpResponseMessage;
        Content: Text;
        Response: Text;
        XMLDoc: XmlDocument;
        XMLNodeList: XmlNodeList;
        XmlNode: XmlNode;
        NodeText: Text;
        XMLBuffer: Record "XML Buffer";
    begin
        //  Pobranie Tokenu Autoryzacji
        Token := GetToken();
        //  Adres Serwera z którym chcemy się skomunikować (z dokumentacji)
        URL := 'https://parts-api-orders-2-3-cert.deere.com/parts/cert/PMLinkWS_1_3Service';
        //  Budowanie request
        //  Nagłówek - pobieram domyślne i od razu kasuje wszystkie
        HttpHeader := HttpClient.DefaultRequestHeaders;
        //  W autoryzacji używamy Tokena -> Bearer jest to uwierzytelnienie na okaziciela, czyli Tokena, Nagłówek Authorization jest domyślny więc najpierw trzeba go usunąć
        HttpHeader.Add('Authorization', StrSubstNo('Bearer %1', Token));
        //  W tym konktetnym przykładzie w Body Request przekazujemy XML'a (może być JSON lub coś innego to zależy już od API) dlatego prosto z funkcji na sztywno -> pobieram go.
        Content := GetXML();
        HttpContent.WriteFrom(Content);
        //  Dokładam nagłówki z Contentu
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Clear();
        //  Są różne Content-Type: json, xml, etc. ale to domyślny nagłówek więc najpierw muszę go usunąć
        HttpHeader.Remove('Content-Type');
        HttpHeader.Add('Content-Type', 'application/xml');
        //  Nagłówki jakie dodajemy znajdują się w dokumentacji albo w POSTMAN w konsoli poniższy nagłówek nie jest domyślny jest stricte z dokumentacji więc nie muszę go najpier usuwać
        HttpHeader.Add('sm_user', '480461');

        HttpClient.Post(URL, HttpContent, HttpRespone);
        HttpRespone.Content.ReadAs(Response);

        // Odpowiedź
        Message(Response);

        // Obróbka otrzymanego XML'a z komunikatem zwrotynym
        XMLBuffer.LoadFromText(Response);
        XMLBuffer.SetRange(Name, 'responseMessage');
        if XMLBuffer.FindSet() then
            repeat
                Message(XMLBuffer.Value);
            until XMLBuffer.Next() < 1;

        // Sposób bardziej zaawansowany
        XmlDocument.ReadFrom(Response, XMLDoc);
        XMLDoc.SelectNodes('//submitOrderReturn', XMLNodeList);
        foreach xmlNode in XMLNodeList do begin
            NodeText := Format(XmlNode.AsXmlElement().InnerText);
            Message(NodeText);
        end;
    end;


    procedure GetToken() Token: Text
    var
        URL: Text;
        TokenURL: Text;
        ClientID: Text;
        ClientSecretID: Text;
        HttpClient: HttpClient;
        HttpHeader: HttpHeaders;
        HttpContent: HttpContent;
        HttpResponse: HttpResponseMessage;
        RequestBody: Text;
        Response: Text;
        Json: JsonObject;
        JsonToken: JsonToken;
    begin
        //  Adres serwera/zasobu który wygeneruje nam token
        TokenURL := 'https://sso-cert.johndeere.com/oauth2/aus9mimdb1f6lBjCs1t7/v1/token';
        //  Nazwa użytkownika
        ClientID := '0oaqsf2v67vfkFR7K1t7';
        //  Hasło 
        ClientSecretID := 'hMvICxSn4-qG6E0Iv_FdVAqRat6rqHQ8VUKhCIDS';

        // Request przygotowany na podstawie POSTMAN - zrzut ekrany w plikach "OAuth 2.0 Postman.png"
        HttpHeader := HttpClient.DefaultRequestHeaders();
        RequestBody := StrSubstNo('grant_type=client_credentials&client_id=%1&client_secret=%2', ClientID, ClientSecretID);
        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Clear();
        // Content Type najlepiej podejrzeć w POSTMAN w konsoli -> jak już wyślesz zapytanie, klikasz Ctrl+Alt+C wyskakuje konsola a w niej wszystkie Request, a w nich wszystkie informacje jakie trzeba użyć do zbudowania Request
        HttpHeader.Add('Content-Type', 'application/x-www-form-urlencoded');
        HttpClient.Post(TokenURL, HttpContent, HttpResponse);

        if HttpResponse.IsSuccessStatusCode then begin
            HttpResponse.Content.ReadAs(Response);
            Json.ReadFrom(Response);
            Json.Get('access_token', JsonToken);
            if JsonToken.IsValue then begin
                JsonToken.WriteTo(Token);
                Token := DelChr(Token, '<>', '"');
            end;
        end;
    end;

    local procedure GetXML() XML: Text
    begin
        XML := '<?xml version="1.0" encoding="UTF-16" standalone="no"?>'
                + '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://v1_3.pmlink.services.view.jdpoint.parts.deere.com" xmlns:bean="http://beans.v1_3.pmlink.services.view.jdpoint.parts.deere.com">'
                + '<soapenv:Header />'
                + '<soapenv:Body>'
                    + '<v1:submitOrder>'
                    + '<v1:orderBean>'
                        + '<bean:accountId>tp23126</bean:accountId>'
                        + '<bean:orderType>MD</bean:orderType>'
                        + '<bean:receivedBy>P</bean:receivedBy>'
                        + '<bean:willCall>S</bean:willCall>'
                        + '<bean:orderLines>'
                        + '<bean:orderedQuantity>1</bean:orderedQuantity>'
                        + '<bean:partNumber>0251272</bean:partNumber>'
                        + '</bean:orderLines>'
                    + '</v1:orderBean>'
                    + '</v1:submitOrder>'
                + '</soapenv:Body>'
                + '</soapenv:Envelope>';
        exit(XML);
    end;
}
