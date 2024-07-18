codeunit 50154 "Work With Email"
{
    procedure SendEmail()
    var
        Message: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenerio: Enum "Email Scenario";
    begin
        Message.Create('pitrakarol@gmail.com', 'Temat', 'Cześć to jest treś maila');
        Email.Send(Message, EmailScenerio::Reminder);
    end;

    internal procedure SendEmailSalesOrderPDF(IssuedReminderHeader: Record "Issued Reminder Header")
    var
        Message: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailScenerio: Enum "Email Scenario";
        TempBlob: Codeunit "Temp Blob";
        TempBlob2: Codeunit "Temp Blob";
        OutStrPDF: OutStream;
        OutStrHTML: OutStream;
        InStrPDF: InStream;
        InStrHTML: InStream;
        Param: Text;
        RecRef: RecordRef;
        Base64Convert: Codeunit "Base64 Convert";
        PDFTxt: Text;
        PDFBase64: Text;
        FileName: Text;
        HTMLBody: Text;
        ProFormaRep: Report "Standard Sales - Pro Forma Inv";
        ReportSelection: Record "Report Selections";
    begin
        RecRef.Get(IssuedReminderHeader.RecordId);
        Param := Report.RunRequestPage(Report::Reminder, '');
        //Param := StrSubstNo('<?xml version="1.0" standalone="yes"?><ReportParameters name="Issue Reminders" id="190"><Options><Field name="PrintEmailDocument">0</Field><Field name="ReplacePostingDate">false</Field><Field name="ReplaceVATDateReq">false</Field><Field name="PostingDateReq" /><Field name="VATDateReq" /><Field name="HideDialog">false</Field><Field name="GenJnlLineReq.quot;Journal Template Namequot;" /><Field name="GenJnlLineReq.quot;Journal Batch Namequot;" /></Options><DataItems><DataItem name="Reminder Header">VERSION(1) SORTING(Field1) WHERE(Field1=1(%1))</DataItem></DataItems></ReportParameters>', IssuedReminderHeader."No.");

        TempBlob.CreateOutStream(OutStrPDF);
        Report.SaveAs(Report::Reminder, Param, ReportFormat::Pdf, OutStrPDF, RecRef);
        TempBlob.CreateInStream(InStrPDF);

        // Bardzo Ważne!
        // Jeżeli pojawi się błąd podczas exportu do Html "Bieżący format układu raportu nie obsługuje formatu danych wyjściowych Html."
        // Należy ustawić e wyborze raportu Typ układu "Word" zamiast RDLC, Microsoft chyba poprawił ten Bug od wersji 23.1
        TempBlob2.CreateOutStream(OutStrHTML);
        Report.SaveAs(Report::Reminder, Param, ReportFormat::Html, OutStrHTML);
        TempBlob2.CreateInStream(InStrHTML);
        InStrHTML.Read(HTMLBody);

        Message.Create('', '', '');
        Message.SetRecipients(Enum::"Email Recipient Type"::"To", 'kpitra@solidexpert.com');
        Message.SetSubject('Monit HTML');
        Message.SetBody(HTMLBody);

        // Jeżeli mamy w HTML to dodajemy ten parametr
        Message.SetBodyHTMLFormatted(true);
        Message.AddAttachment('Załącznik 1.pdf', 'application/pdf', Base64Convert.ToBase64(InStrPDF));
        Email.Send(Message);

        Message('Wysłano maila najnowszym sposobem');
    end;
}
