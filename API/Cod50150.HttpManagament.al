codeunit 50150 "Http Managament"
{
    procedure HttpRequestCatFact()
    var
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        URL: Label 'https://catfact.ninja/fact';
        Response: Text;
    begin
        if HttpClient.Get(URL, ResponseMessage) then begin
            ResponseMessage.Content.ReadAs(Response);
            Message(Response);
        end;
    end;

    procedure CallAPISalesInvoice(SalesInvHdr: Record "Sales Invoice Header")
    var

        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        RequestHeader: HttpHeaders;
        URL: Text;
        Response: Text;
        businesscentralPrefix: Text;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        businesscentralPrefix := 'NewTest/BC';
        URL := StrSubstNo('http://%1/api/v1.0/companies(%2)/salesInvoices(%3)/pdfDocument', businesscentralPrefix, CompanyName, SalesInvHdr.SystemId);
        RequestMessage.SetRequestUri(URL);
        RequestMessage.Method('GET');
        RequestMessage.GetHeaders(RequestHeader);
        RequestHeader.Add('Authorization', 'Basic ' + Base64Convert.ToBase64('dev:Logon2me'));

        if HttpClient.Send(RequestMessage, ResponseMessage) then begin
            ResponseMessage.Content.ReadAs(Response);
            Message(Response);
        end else begin
            Message('FAIL :(');
        end;
    end;

    procedure GetPDFInvoice(SalesInvHdr: Record "Sales Invoice Header")
    var
        StandardSalesInvRpt: Report "Standard Sales - Invoice";
        ReportFormar: ReportFormat;
        OutStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RequestPageParameters: Text;
        PDFTxt: Text;
        PDFBase64: Text;
    begin
        RequestPageParameters := '<?xml version="1.0" standalone="yes"?><ReportParameters name="Standard Sales - Invoice" id="1306"><Options><Field name="LogInteraction">true</Field><Field name="DisplayAssemblyInformation">false</Field><Field name="DisplayShipmentInformation">false</Field><Field name="DisplayAdditionalFeeNote">false</Field></Options><DataItems><DataItem name="Header">VERSION(1) SORTING(Field3) WHERE(Field3=1(103001))</DataItem><DataItem name="Line">VERSION(1) SORTING(Field3,Field4)</DataItem><DataItem name="ShipmentLine">VERSION(1) SORTING(Field1,Field2,Field3)</DataItem><DataItem name="AssemblyLine">VERSION(1) SORTING(Field2,Field3)</DataItem><DataItem name="WorkDescriptionLines">VERSION(1) SORTING(Field1)</DataItem><DataItem name="VATAmountLine">VERSION(1) SORTING(Field5,Field9,Field10,Field13,Field16)</DataItem><DataItem name="VATClauseLine">VERSION(1) SORTING(Field5,Field9,Field10,Field13,Field16)</DataItem><DataItem name="ReportTotalsLine">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LineFee">VERSION(1) SORTING(Field1)</DataItem><DataItem name="PaymentReportingArgument">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LeftHeader">VERSION(1) SORTING(Field1)</DataItem><DataItem name="RightHeader">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LetterText">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Totals">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>';
        TempBlob.CreateOutStream(OutStr);
        StandardSalesInvRpt.SaveAs(RequestPageParameters, ReportFormar::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);
        InStr.Read(PDFTxt);
        PDFBase64 := Base64Convert.ToBase64(PDFTxt);
        Message(PDFBase64);
    end;
}
