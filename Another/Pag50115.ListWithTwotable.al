page 50115 "List With Two table"
{
    ApplicationArea = All;
    Caption = 'List With Two table';
    PageType = List;
    SourceTable = "Sales Header";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(CustomerBalance; Customer.Balance)
                {
                }
                field(CustomerPaymentTermsCode; Customer."Payment Terms Code")
                {
                    trigger OnValidate()
                    begin
                        // Aby rekord można było modyfikować z poziomu listy trzeba dodać trigger OnValidate + poniższy kod
                        Customer.Validate("Payment Terms Code");
                        Customer.Modify();
                    end;
                }
            }
        }
    }

    var
        Customer: Record Customer;

    trigger OnAfterGetCurrRecord()
    begin
        RefreshLine();
    end;

    trigger OnAfterGetRecord()
    begin
        RefreshLine();
    end;

    local procedure RefreshLine()
    begin
        Customer.SetAutoCalcFields(Balance);
        if not Customer.Get(Rec."Bill-to Customer No.") then
            Clear(Customer);
    end;
}
