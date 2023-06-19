pageextension 50100 "Ext Sales Invoice" extends "Sales Invoice"
{
    actions
    {
        addafter("&Invoice")
        {
            action("Create Document")
            {
                trigger OnAction()
                var
                    CreateDoc: Codeunit "Create Document Managament";
                begin
                    CreateDoc.CreateShippingDocument(Rec);
                end;
            }
            action(ShowSingleton)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Singleton: Codeunit "Single Unit";
                begin
                    Singleton.ShowTxt();
                end;
            }
            action(SaveToPDF)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IInvoiceSaver: Interface "IInvoice Saver";
                    InvoiceSaver: Codeunit "Invoice Saver";
                    SaveToPDF: Codeunit "Save Invoice To PDF";
                begin
                    IInvoiceSaver := SaveToPDF;
                    InvoiceSaver.CtorInvoiceSaver(Rec, IInvoiceSaver);
                    InvoiceSaver.Save();
                end;
            }
            action(SaveToWORD)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IInvoiceSaver: Interface "IInvoice Saver";
                    InvoiceSaver: Codeunit "Invoice Saver";
                    SaveToWORD: Codeunit "Save Invoice To WORD";
                begin
                    IInvoiceSaver := SaveToWORD;
                    InvoiceSaver.CtorInvoiceSaver(Rec, IInvoiceSaver);
                    InvoiceSaver.Save();
                end;
            }
            action(PrintCanon)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IPrinter: Interface "IPrinter";
                    IScan: Interface "IScan";
                    Printer: Codeunit "Canon Printer";
                begin
                    IPrinter := Printer;
                    IPrinter.PrintColor(Rec);
                    IPrinter.PrintGrey(Rec);

                    IScan := Printer;
                    IScan.Scan(Rec);
                end;
            }
            action(PrintHP)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IFax: Interface "IFax";
                    IScan: Interface "IScan";
                    Printer: Codeunit "HP Printer";
                begin
                    IFax := Printer;
                    IFax.Fax(Rec);

                    IScan := Printer;
                    IScan.Scan(Rec);
                end;
            }
            action(PrintBrother)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IFax: Interface "IFax";
                    IScan: Interface "IScan";
                    IPrinter: Interface "IPrinter";
                    Printer: Codeunit "Brother Printer";
                begin
                    IPrinter := Printer;
                    IPrinter.PrintColor(Rec);
                    IPrinter.PrintGrey(Rec);

                    IFax := Printer;
                    IFax.Fax(Rec);

                    IScan := Printer;
                    IScan.Scan(Rec);
                end;
            }
            action(DocumentNotyfication)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    INotyfication: Interface INotyfication;
                    Notyfication: Codeunit "Document Sender";
                    SMSNotyf: Codeunit "SMS Notyfication";
                    EMailNotyf: Codeunit "Email Notyfication";
                begin
                    INotyfication := SMSNotyf;
                    Notyfication.SetINotyfication(INotyfication);
                    Notyfication.SendDocumentNotyfication(Rec);

                    INotyfication := EMailNotyf;
                    Notyfication.SetINotyfication(INotyfication);
                    Notyfication.SendDocumentNotyfication(Rec);
                end;
            }
            action(Builder)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Builder: Codeunit "Invoice Builder";
                    Items: Record Item;
                    NewSalesInv: Record "Sales Header";
                begin
                    Items.FindFirst();

                    Builder.Init();
                    Builder.SetCustomer(Rec."Bill-to Customer No.");
                    Builder.SetDate(WorkDate());
                    Builder.SetSalesLine(Items);
                    NewSalesInv := Builder.Build();
                    Page.Run(Page::"Sales Invoice", NewSalesInv);
                end;
            }
            action(Factory)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    IDocument: Interface IDocument;
                    FactoryDoc: Codeunit "Document Factory";
                begin
                    IDocument := FactoryDoc.GetCodeunitImplementation(Rec.RecordId.TableNo);
                    IDocument.CreateDocument();

                    IDocument := FactoryDoc.GetCodeunitImplementation(Database::Job);
                    IDocument.CreateDocument();
                end;
            }
            action(SendNotyf)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Notyfication: Codeunit "Notyfication Document";
                begin
                    Notyfication.SendDocument(Rec, Enum::"Notyfication Type"::SMS);
                end;
            }
        }
    }
}
