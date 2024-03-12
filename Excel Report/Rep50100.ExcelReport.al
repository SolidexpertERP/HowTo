report 50100 "Excel Report"
{
    Caption = 'Excel Report';
    //ExcelLayout = '';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.") { }
            column(Balance; Balance) { }
            //column(New_Balance; New_Balance) { }
        }
    }
}
