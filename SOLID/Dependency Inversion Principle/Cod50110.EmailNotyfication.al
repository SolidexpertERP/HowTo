codeunit 50110 "Email Notyfication" implements INotyfication
{

    procedure SendNotyfication(Document: Variant)
    begin
        SendEmailNotyfication(Document);
    end;

    local procedure SendEmailNotyfication(Document: Variant)
    begin
        Message('Hello i send This document Email...');
    end;

}
