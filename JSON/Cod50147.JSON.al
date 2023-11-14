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


}
