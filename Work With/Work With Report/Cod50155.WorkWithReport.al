codeunit 50155 "Work With Report"
{
    /// <summary>
    /// Funkcja mająca na celu wywołać request page raportu, ustawienie swoich parametrów i pobranie z niego ustawionych parametrów w postaci XML'a/Text'u
    /// Funkcja nie uruchamia raportu
    /// </summary>
    procedure GetReportParams(): Text
    var
        Param: Text;
    begin
        // Otwarcie Request Page do ustawienia swoich parametrów bez wywołania raportu
        Param := Report.RunRequestPage(Report::"Standard Sales - Pro Forma Inv");
        // Pobrane parametry możemy sobie zapisać w tabeli lub na sztywno i wywoływać raport
        Message(Param);
        exit(Param);
    end;

    /// <summary>
    /// Funkcja mająca na celu wywołanie raportu, bez request page ale z paramatrami
    /// I zapisanie go do PDF
    /// </summary>
    procedure RunReportWithoutRequestPageAndSaveToPDF()
    var
        SalesOrder: Record "Sales Header";
        StandardSalesProFormaInv: Report "Standard Sales - Pro Forma Inv";
        TempBlob: Codeunit "Temp Blob";
        Param: Text;
        DocumentNo: Text;
        OutStr: OutStream;
        InStr: InStream;
        RecRef: RecordRef;
        FileName: Text;
    begin
        DocumentNo := '101005';
        SalesOrder.Get(SalesOrder."Document Type"::Order, DocumentNo);
        RecRef.Get(SalesOrder.RecordId);

        // Parametry pobrane z funkcji GetReportParams
        Param := StrSubstNo('<?xml version="1.0" standalone="yes"?><ReportParameters name="Standard Sales - Pro Forma Inv" id="1302"><DataItems><DataItem name="Header">VERSION(1) SORTING(Field1,Field3) WHERE(Field3=1(%1))</DataItem><DataItem name="Line">VERSION(1) SORTING(Field3,Field4)</DataItem><DataItem name="WorkDescriptionLines">VERSION(1) SORTING(Field1)</DataItem><DataItem name="Totals">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>', DocumentNo);
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Standard Sales - Pro Forma Inv", Param, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);
        FileName := 'Invoice.pdf';
        File.DownloadFromStream(InStr, '', '', '', FileName);
    end;

    procedure SendDocumentEmail(IssuedReminderHeader: Record "Issued Reminder Header")
    var
        CUEmail: Codeunit "Work With Email";
    begin
        CUEmail.SendEmailSalesOrderPDF(IssuedReminderHeader);
    end;
}
