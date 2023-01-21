/// <summary>
/// Dzięki interface i codeunit które go implementuje, można zwracać implementacę codeunit (C/AL umożliwia bezpośrednie rzutowanie Codeunit na Interface)
/// Ten Codeunit w zależności od przekazanego parametru zwraca implementację wybranefo coedunit. Pozwala to implementować go w różnych obiektach. Dodatkowo
/// oddzielamy implementację niskopoziomową, od wysokopoziomowej w postaci Page, Table. 
/// </summary>
codeunit 50116 "Document Factory"
{
    procedure GetCodeunitImplementation(TableId: Integer): Interface IDocument
    var
        CreateJob: Codeunit "Create Job";
        CreateSalesOrder: Codeunit "Create Sales Order";
        CreateInvoice: Codeunit "Create Invoice";
    begin
        case TableId of
            Database::Job:
                exit(CreateJob);
            Database::"Sales Header":
                exit(CreateSalesOrder);
            Database::"Sales Invoice Header":
                exit(CreateInvoice);
            else
                Error('Table Id is not implemented', TableId);
        end;
    end;
}
