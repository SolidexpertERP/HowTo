codeunit 50147 JSON
{
    procedure CreateSimpleJSON()
    var
        JsonObj: JsonObject;
        Txt: Text;
    begin
        JsonObj := CreateJSON();
        JsonObj.WriteTo(Txt);
        Message(Txt);
    end;

    local procedure CreateJSON(): JsonObject
    var
        JsObject: JsonObject;
        JsObject2: JsonObject;
        JsArray: JsonArray;
        valInteger: JsonValue;
        valDecimal: JsonValue;
        valIsTrue: JsonValue;
        valNull: JsonValue;
        valDate: JsonValue;
        version: Code[20];
    begin
        valInteger.SetValue(1000);
        valDecimal.SetValue(10.546363);
        valIsTrue.SetValue(true);
        valNull.SetValueToNull();
        valDate.SetValue(Today);

        JsObject2.Add('from', valInteger);
        JsObject2.Add('boolean', valIsTrue);
        JsObject2.Add('valNull', valNull);
        JsObject2.Add('valDate', valDate);
        JsArray.Add(JsObject2);

        version := 'v 1.0.0';
        JsObject.Add('versja', version);
        JsObject.Add('Tablica Zmiennych', JsArray);
        exit(JsObject);
    end;

    procedure CreateJSON2()
    var
        obj: JsonObject;
        O2: JsonObject;
        item: JsonObject;
        Token: JsonToken;
        T2: JsonToken;
        T3: JsonToken;
        ja: JsonArray;
        v: JsonValue;
        txt: Text;
    begin
        obj.Add('field', 'Youtube Video');

        v.SetValue(123.456);
        obj.Add('Price', v);

        obj.Add('version', '0.2.0');
        item.add('No', 20201110D);
        ja.add(item);
        clear(item);
        item.add('No', 20201112D);
        ja.add(item);
        ja.Add(100);
        ja.Add(200);
        obj.Add('Items', ja);

        if obj.Contains('Items') then begin
            obj.get('Items', Token);
            foreach T2 in Token.AsArray() do begin
                if T2.IsObject() then begin
                    O2 := T2.AsObject();
                    O2.Get('No', T3);
                    if T3.IsValue() then begin
                        V := T3.AsValue();
                        Message('Value as Date %1', CalcDate('+5D', V.AsDate()));
                    end;
                end;
            end;
        end;

        //obj.WriteTo(txt);
        //Message(txt);
    end;

    procedure CreateJSON3()
    var
        Json: JsonObject;
        JsonTxt: Text;
        Token1: JsonToken;
        ListOfText: List of [Text];
    begin
        Json.Add('name', 'Json Test');
        Json.Add('version', '1.0.0.0');
        Json.Add('array', CreateJsonArray());

        ListOfText := Json.Keys();
        foreach JsonTxt in ListOfText do begin
            Message(JsonTxt);
        end;

        Json.Replace('name', 'xxx'); //zastępuje name ale przesuwa go na koniec JSON'a

        Json.WriteTo(JsonTxt);
        Message(JsonTxt);
    end;

    local procedure CreateJsonArray() JSArray: JsonArray
    var
        JSObj: JsonObject;
        i: Integer;
    begin
        for i := 1 to 10 do begin
            Clear(JSObj);
            JSObj.Add('nr', i);
            JSObj.Add('nazwa', 'jakaś nazwa');
            JSArray.Add(JSObj);
        end;
        Message(JSObj.Path()); // wskazuje jak głęboko zagbieżdżony jest element -> JSObj.Path() = [9]
        Message(JSArray.Path()); // JSObj.Path() = pusty ciąg znaków bo to ROOT
    end;
}
