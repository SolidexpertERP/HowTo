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

    local procedure SetFilter(var Rec: Record Customer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRefNo: FieldRef;
    begin
        RecRef.Open(Rec.RecordId.TableNo);
        RecRef.Copy(Rec);
        DataTypeMgt.FindFieldByName(RecRef, FldRefNo, 'No.');
        FldRefNo.SetFilter('ALA');
        RecRef.SetTable(Rec);
    end;

    local procedure SetFilter2(var Rec: Record Customer)
    var
        DataTypeMgt: Codeunit "Data Type Management";
        RecRef: RecordRef;
        FldRefNo: FieldRef;
    begin
        RecRef.Open(Rec.RecordId.TableNo);
        RecRef.Copy(Rec);
        DataTypeMgt.FindFieldByName(RecRef, FldRefNo, 'Name');
        FldRefNo.SetFilter('ALA');
        RecRef.SetTable(Rec);
    end;

    local procedure SetFilterVariant(RecVariant: Variant): Variant
    var
        DataTypeMgt: Codeunit "Data Type Management";
        OutVariant: Variant;
        RecRef: RecordRef;
        FldRefNo: FieldRef;
    begin
        DataTypeMgt.GetRecordRef(RecVariant, RecRef);
        DataTypeMgt.FindFieldByName(RecRef, FldRefNo, 'Name');
        FldRefNo.SetFilter('ALA');
        RecRef.GetTable(OutVariant);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer List", 'OnOpenPageEvent', '', true, true)]
    local procedure SetFilterCustomerList(var Rec: Record Customer)
    begin
        SetFilter(Rec);
        SetFilter2(Rec);
        //Rec := SetFilterVariant(Rec); // <- przez Variant nie działa...
    end;
}
