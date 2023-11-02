codeunit 50137 "My Codeunit Managament"
{
    TableNo = Customer;

    trigger OnRun()
    begin
        Customer.Copy(Rec);
        CreateCopyCustomer();
        Rec.Copy(Customer);
        Error('Upssss....error');
    end;

    var
        Customer: Record Customer;

    procedure CreateCopyCustomer()
    begin
        Customer."Name 2" := Customer."Name 2" + ' !@#';
    end;

    /// <summary>
    /// Sprawdzenie jak działa procedura ze zmiennymi Option i przekazanie Option jako int
    /// </summary>
    /// <param name="Message"></param>
    /// <param name="DocHdr"></param>
    /// <param name="HideDialog"></param>
    procedure ProcedureWithOptionalParam(Message: Text; DocHdr: Option "Sales Header","Purchase Header"; HideDialog: Boolean)
    begin
        Message('%1', DocHdr);
    end;
}
