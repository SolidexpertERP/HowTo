codeunit 50148 "Sales Managament"
{
    trigger OnRun()
    begin
    end;

    var
        DataTypeMgt: Codeunit "Data Type Management";
        SalesInvoiceTmp: Record "Sales Header" temporary;
        SalesInvoiceLineTmp: Record "Sales Line" temporary;
        MessageInvoiceCreate: Label 'Invoice Created %1', Comment = '%1 - Invoice No.';
        ErrorSalesInvCreateNotImplemented: Label 'Create Sales Invoice from %1 not implemented', Comment = '%1 - Table Caption or document type';
        ErrorDocumentType: Label 'Error document type.\Incoming Docuemtn type: %1\Expected docuemtn type: %2';

    procedure CreateSalesInvoice(FromDocumentRecId: RecordId; OpenAfterCreated: Boolean; OpenAfterCreatedWithQuestion: Boolean) SalesInvoice: Record "Sales Header";
    var
        FromDocumentRecRef: RecordRef;
    begin
        SetupRecordRef(FromDocumentRecRef, FromDocumentRecId);
        EncodingRecordRef(FromDocumentRecRef);
        SalesInvoice := CreateSalesInvoiceFromTemporary(SalesInvoiceTmp, SalesInvoiceLineTmp);

        if OpenAfterCreated then
            OpenSalesHeader(SalesInvoice, OpenAfterCreatedWithQuestion);
    end;

    local procedure SetupRecordRef(var RecRef: RecordRef; RecId: RecordId)
    begin
        RecRef.Get(RecId);
    end;

    local procedure EncodingRecordRef(FromDocumentRecRef: RecordRef)
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Job: Record Job;
    begin
        case FromDocumentRecRef.Number of
            Database::"Sales Header":
                begin
                    SalesHeader.Get(FromDocumentRecRef.RecordId);
                    EncodingRecordSalesHeader(SalesHeader);
                end;
            Database::"Sales Invoice Header":
                begin
                    SalesInvoiceHeader.Get(FromDocumentRecRef.RecordId);
                    EncodingRecordSalesInvoiceHeader(SalesInvoiceHeader);
                end;
            Database::Job:
                begin
                    Job.Get(FromDocumentRecRef.RecordId);
                    EncodingRecordJob(Job);
                end;
            else
                Error(ErrorSalesInvCreateNotImplemented, FromDocumentRecRef.Caption);
        end;
    end;

    local procedure EncodingRecordSalesHeader(SalesHeader: Record "Sales Header")
    begin
        case SalesHeader."Document Type" of
            "Sales Document Type"::"Blanket Order":
                EncodingRecordBlanketOrder(SalesHeader);
            "Sales Document Type"::Order:
                EncodingRecordSalesOrder(SalesHeader);
            "Sales Document Type"::Quote:
                EncodingRecordSalesQuote(SalesHeader);
            else
                Error(ErrorSalesInvCreateNotImplemented, SalesHeader."Document Type");
        end;
    end;

    /// <summary>
    /// Funkcja do zrzutowania/zdekodowania Blank Order na tymczasowy nagłówek i wiersze z których później zostanie utworzona właściwa faktura
    /// </summary>
    /// <param name="SalesHeader"></param>
    local procedure EncodingRecordBlanketOrder(SalesHeader: Record "Sales Header")
    begin
        CheckDocumentType(SalesHeader."Document Type", SalesHeader."Document Type"::"Blanket Order", true);
        SalesInvoiceTmp.DeleteAll();
        SalesInvoiceTmp.TransferFields(SalesHeader, false);
        SalesInvoiceTmp.Insert(true);
    end;

    /// <summary>
    /// Funkcja do zrzutowania/zdekodowania Sales Order na tymczasowy nagłówek i wiersze z których później zostanie utworzona właściwa faktura
    /// </summary>
    /// <param name="SalesHeader"></param>
    local procedure EncodingRecordSalesOrder(SalesHeader: Record "Sales Header")
    begin
    end;

    /// <summary>
    /// Funkcja do zrzutowania/zdekodowania Sales Quote na tymczasowy nagłówek i wiersze z których później zostanie utworzona właściwa faktura
    /// </summary>
    /// <param name="SalesHeader"></param>
    local procedure EncodingRecordSalesQuote(SalesHeader: Record "Sales Header")
    begin
    end;

    /// <summary>
    /// Funkcja do zrzutowania/zdekodowania "Sales Invoice Header" na tymczasowy nagłówek i wiersze z których później zostanie utworzona właściwa faktura
    /// </summary>
    /// <param name="SalesInvoiceHeader"></param>
    local procedure EncodingRecordSalesInvoiceHeader(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    /// <summary>
    /// Funkcja do zrzutowania/zdekodowania "Job" na tymczasowy nagłówek i wiersze z których później zostanie utworzona właściwa faktura
    /// </summary>
    /// <param name="Job"></param>
    local procedure EncodingRecordJob(Job: Record Job)
    begin
    end;

    local procedure CheckDocumentType(DocumentTypeToCheck: Enum "Sales Document Type"; ExpectedDocumentType: Enum "Sales Document Type"; WithError: Boolean) IsSameValue: Boolean
    begin
        IsSameValue := DocumentTypeToCheck = ExpectedDocumentType;

        if not IsSameValue then
            if WithError then
                Error(ErrorDocumentType, DocumentTypeToCheck, ExpectedDocumentType);
    end;

    local procedure OpenSalesHeader(var SalesHeader: Record "Sales Header"; WithQuestion: Boolean)
    var
        QuestionOpenDocument: Label 'Do you want open %1?';
        ErrorOpenRecord: Label 'Open Record %1 %2 not implemented';
    begin
        if WithQuestion then
            if not Dialog.Confirm(StrSubstNo(QuestionOpenDocument, SalesHeader."No.")) then
                exit;

        case SalesHeader."Document Type" of
            "Sales Document Type"::"Blanket Order",
            "Sales Document Type"::Order:
                Page.Run(Page::"Sales Order", SalesHeader);
            "Sales Document Type"::Invoice:
                Page.Run(Page::"Sales Invoice", SalesHeader);
            else
                Error(ErrorOpenRecord, SalesHeader.TableCaption, SalesHeader."Document Type")
        end;
    end;

    local procedure CreateSalesInvoiceFromTemporary(var SalesInvoiceTmp: Record "Sales Header" temporary; var SalesInvoiceLineTmp: Record "Sales Line" temporary) SalesInvoice: Record "Sales Header";
    var
        ErrorTableIsEmptyCheckEncodingIncomingRecord: Label '%1 not implemented. Chceck encoding incoming record to %1';
    begin
        if SalesInvoiceTmp.IsEmpty then
            Error(ErrorTableIsEmptyCheckEncodingIncomingRecord, SalesInvoiceTmp.TableCaption);

        // Tutaj już konkretna implementacja funkcji tworzącej Fakturę sprzedaży, tak aby każda faktura z różnych rekordów była generowana w ten sam sposób
        SalesInvoice.Init();
        SalesInvoice.TransferFields(SalesInvoiceTmp);
        SalesInvoice.Insert(true);
    end;


}
