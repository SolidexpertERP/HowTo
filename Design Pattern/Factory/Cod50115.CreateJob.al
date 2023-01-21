codeunit 50115 "Create Job" implements IDocument
{

    procedure CreateDocument()
    begin
        CreateJob();
    end;

    local procedure CreateJob()
    begin
        Message('Hello create JOB!');
    end;

}
