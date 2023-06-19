codeunit 50124 "Master Managament"
{
    var
        TypeNotyfication: Enum "Type Notyfication";
        DataTypeMgt: Codeunit "Data Type Management";
        INotification: Interface INotification;
        IBuilderNotification: Interface IBuilderNotyfication;
        RecRef: RecordRef;
        Message: Text;

    procedure DocumentNotification(Document: Variant)
    var
        MessageToSend: Text;
    begin
        DataTypeMgt.GetRecordRef(Document, RecRef);
        NotificationFactory(RecRef.Number, INotification, IBuilderNotification);
        Message := IBuilderNotification.CreateMessage(RecRef);
        INotification.SendNotyfication(Message);
    end;

    procedure NotificationFactory(TableId: Integer; var Notyf: Interface INotification; var Builder: Interface IBuilderNotyfication)
    var
        Configuration: Record Configuration;
    begin
        Configuration.SetRange("Table ID", TableId);
        if Configuration.FindFirst() then begin
            INotification := Configuration."Type Notification";
            Builder := Configuration."Type Notification";
        end else
            Error('Table id: %1 not implemented. Add configuration to Config table', TableId);
    end;
}
