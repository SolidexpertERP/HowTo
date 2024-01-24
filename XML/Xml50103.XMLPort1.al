/// <summary>
/// XML Port który używa NamespacePrefix, czyli prefixu np. "soapenv" w każdym tagu XML'a np. soapenv:Envelope. Prefix jest dostępny tylko w XML'porcie
/// nie można zbudować takiego XML'a tradycyjnym sposobem
/// </summary>
xmlport 50103 "XML Port 1"
{
    Format = xml;
    Namespaces = soapenv = 'http://schemas.xmlsoap.org/soap/envelope/',
                      v1 = 'http://v1_3.pmlink.services.view.jdpoint.parts.deere.com',
                    bean = 'http://beans.v1_3.pmlink.services.view.jdpoint.parts.deere.com';
    UseDefaultNamespace = false;

    schema
    {
        textelement("Envelope")
        {
            NamespacePrefix = 'soapenv'; /*Prefix soapenv:Envelope*/

            textelement("Header") /*textelement - element typu text, taki na "sztywno"*/
            {
                NamespacePrefix = 'soapenv';
            }
            textelement("Body")
            {
                NamespacePrefix = 'soapenv';

                textelement("submitOrder")
                {
                    NamespacePrefix = 'v1';

                    tableelement(SalesHdr; "Sales Header") /*tableelement - element na podstawie danych z tabeli*/
                    {
                        XmlName = 'orderBean'; /*zmiana nazwy tagu na inny niż nazwa tabeli tj. SalesHdr*/
                        NamespacePrefix = 'v1';

                        textelement(accountId)
                        {
                            MaxOccurs = Once;

                            trigger OnBeforePassVariable()
                            begin
                                // Jeżeli odwołujemy się do jakiegoś tagu który jest poniżej/dalej w generowanym pliku XML, to musimy pamiętać że wewnątrz 
                                // zmiennej znajduje się wartość z poprzedniej iteracji, ponieważ to jest zwykła pętla po zamówieniach, czyli poniższy if 
                                // wykona się dla kolejnego zamówienia 101004 a nie tego o numerze 101003.
                                if dealerOrderNumber.Contains('101003') then
                                    accountId := 'XYZ123'
                                else
                                    accountId := TestVar;
                            end;
                        }
                        textelement(dateOrdered)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                dateOrdered := Format(SalesHdr."Order Date");
                            end;
                        }
                        textelement(dealerOrderNumber)
                        {
                            trigger OnBeforePassVariable()
                            begin
                                if SalesHdr."No." = '' then
                                    currXMLport.Skip(); // pominięcie jakiegoś tagu jeżeli nie jest wymagany w pliku 
                                dealerOrderNumber := SalesHdr."No.";
                            end;
                        }
                        tableelement(SalesLine; "Sales Line")
                        {
                            LinkTable = SalesHdr;
                            LinkFields = "Document No." = field("No."), "Document Type" = field("Document Type");

                            textelement(customerPartNumber)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    customerPartNumber := SalesLine."No.";
                                    if dealerOrderNumber.Contains('3') then // odwołanie się do jakiegoś pola i na jego podstawie dokonanie jakiejś operacji
                                        customerPartNumber := 'pominięte bo tak...';
                                end;
                            }
                            textelement(drivenPrice)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    drivenPrice := Format(SalesLine.Amount);
                                    if dealerOrderNumber.Trim() = '' then
                                        drivenPrice := 'bezcenne bo nie ma numeru zamówinia';
                                end;
                            }
                        }
                    }
                }
            }


        }
    }

    procedure SetTestVar(ValToSet: Text)
    begin
        TestVar := ValToSet;
    end;

    var
        TestVar: Text;
}
