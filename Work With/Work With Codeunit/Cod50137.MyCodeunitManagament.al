codeunit 50137 "My Codeunit Managament"
{
    TableNo = Customer;

    trigger OnRun()
    begin
        Customer.Copy(Rec);
        CreateCopyCustomer();
        Rec.Copy(Customer);
    end;

    var
        Customer: Record Customer;

    procedure CreateCopyCustomer()
    begin
        Customer."Name 2" := Customer."Name 2" + ' !@#';
    end;
}
