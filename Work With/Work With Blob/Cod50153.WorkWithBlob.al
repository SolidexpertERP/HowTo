codeunit 50153 "Work With Blob"
{
    procedure GetWorkDescription(SalesHdr: Record "Sales Header") MyPictureTxt: Text
    var
        MyInStream: InStream;

    begin
        Clear(MyPictureTxt);
        SalesHdr.Calcfields("My Picture");
        If SalesHdr."My Picture".HasValue() then begin
            SalesHdr."My Picture".CreateInStream(MyInStream);
            MyInStream.Read(MyPictureTxt);
        end;
    end;
}
