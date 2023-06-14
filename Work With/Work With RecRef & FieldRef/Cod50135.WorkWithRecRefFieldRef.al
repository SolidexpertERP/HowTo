codeunit 50135 "Work With RecRef FieldRef"
{
    procedure UpdateCity(RecordToUpdate: Variant; NewCityName: Code[20]; FieldNo: Integer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        if NewCityName = 'RZESZÓW' then
            Error('Nie możesz wprowadzić RZESZÓW');

        DataTypeMgt.GetRecordRef(RecordToUpdate, RecRef);
        FldRef := RecRef.Field(FieldNo);
        FldRef.Validate(NewCityName);
        RecRef.Modify(true);
    end;
}
