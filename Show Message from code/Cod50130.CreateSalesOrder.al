/// <summary>
/// To zadanie ma na celu sprawdzenie czy jeżeli na tabeli dodamy walidację która wyświetla jakiś Message użytkownikowi 
/// 
/// </summary>
codeunit 50130 "Create Sales Order KPI"
{
    procedure CreateSalesOrder()
    var
        SalesOrder: Record "Sales Header";
    begin
        SalesOrder.Init();
        SalesOrder."Document Type" := SalesOrder."Document Type"::Order;
        SalesOrder.Insert();

        SalesOrder.Validate("Sell-to Customer No.", GetFirstCustomerNo());
        SalesOrder.Validate("My Communicat Field", 'Czy się pokaże?');
        SalesOrder.Modify();

        Page.Run(Page::"Sales Order", SalesOrder);
    end;

    local procedure GetFirstCustomerNo(): Code[20]
    var
        Customer: Record Customer;
    begin
        Customer.FindFirst();
        exit(Customer."No.");
    end;
}
