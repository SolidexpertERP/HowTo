query 50100 "Query Example"
{
    Caption = 'Query Example';
    QueryType = Normal;

    elements
    {
        dataitem(C; Customer)
        {
            column(Customer_Number; "No.")
            {
            }

            column(Customer_Name; Name)
            {
            }

            dataitem(SL; "Sales Line")
            {
                DataItemLink = "Sell-to Customer No." = c."No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = Quantity = filter(= 1); // WHERE Quantity = 10

                column(Qty; Quantity)
                {
                    Method = Sum; // SELECT SUM(Qty)...
                    ColumnFilter = Qty = filter(> 0); //HAVING Qty > 0
                }

                column(Document_Type; "Document Type") { }

                filter(Document_No_; "Document No.")
                {
                    // Kolumna która nie jest wyświetlana, złuży do filtrowania
                    ColumnFilter = Document_No_ = filter(<> '102148'); // WHERE Document_No_ <> '102148'
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        // Nadpisanie filtru domyślnego
        //CurrQuery.SetFilter(Document_No_, '102148');
    end;
}
