/// <summary>
/// Codeunit mający na celu sprawdzenie różnych sposobów wyołania walidacji na polu Age w tabeli "Work With CurrFieldNo Table" na którym jest sprawdzany
/// i wyświetlany CurrFieldNo
/// </summary>
codeunit 50134 "Work With CurrFieldNo Codeunit"
{
    TableNo = "Work With CurrFieldNo Table";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.FindFirst();
        Rec.Validate(Age, 15); //CurrFieldNo = 0        
        Rec.Validate(Age2, 15); //CurrFieldNo = 0        
        Rec.Validate(Age, Rec.Age2); //CurrFieldNo = 0        
        Rec.Validate(Age, SalesHeader."No. Printed"); //CurrFieldNo = 0        
    end;

    procedure TestCurrentFieldNo1()
    var
        WorkWithCurrFieldNo: Record "Work With CurrFieldNo Table";
    begin
        WorkWithCurrFieldNo.Init();
        WorkWithCurrFieldNo.Validate(Age, 0); //CurrFieldNo = 0        
    end;

    procedure TestCurrentFieldNo2()
    var
        WorkWithCurrFieldNo: Record "Work With CurrFieldNo Table";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.FindFirst();
        WorkWithCurrFieldNo.Init();
        WorkWithCurrFieldNo.Validate(Age, SalesHeader."No. Printed"); //CurrFieldNo = 0
    end;

    procedure TestCurrentFieldNo3()
    var
        WorkWithCurrFieldNo1: Record "Work With CurrFieldNo Table";
        WorkWithCurrFieldNo2: Record "Work With CurrFieldNo Table";
    begin
        WorkWithCurrFieldNo2.FindFirst();
        WorkWithCurrFieldNo1.Init();
        WorkWithCurrFieldNo1.Validate(Age, WorkWithCurrFieldNo2.Age); //CurrField = 0
    end;

    procedure TestCurrentFieldNo4()
    var
        WorkWithCurrFieldNo1: Record "Work With CurrFieldNo Table";
    begin
        WorkWithCurrFieldNo1.Init();
        WorkWithCurrFieldNo1.Age := 15;
        WorkWithCurrFieldNo1.Validate(Age, WorkWithCurrFieldNo1.Age); //CurrField = 0
    end;

    procedure TestCurrentFieldNo5()
    var
        WorkWithCurrFieldNo1: Record "Work With CurrFieldNo Table";
    begin
        WorkWithCurrFieldNo1.Init();
        WorkWithCurrFieldNo1.Age := 15;
        WorkWithCurrFieldNo1.Validate(Age); //CurrField = 0
    end;

    procedure TestCurrentFieldNo6(WorkWithCurrFieldNo1: Record "Work With CurrFieldNo Table")
    begin
        WorkWithCurrFieldNo1.Age := 15;
        WorkWithCurrFieldNo1.Validate(Age); //CurrField = 0
    end;

    procedure TestCurrentFieldNo7()
    var
        WorkWithCurrFieldNo1: Record "Work With CurrFieldNo Table";
    begin
        WorkWithCurrFieldNo1.Init();
        WorkWithCurrFieldNo1.Validate(Age2, 15); //CurrField = 0        
    end;

    procedure TestCurrentFieldNo8(var WorkWithCurrFieldNo1: Record "Work With CurrFieldNo Table")
    begin
        WorkWithCurrFieldNo1.Validate(Age2, 15); //CurrField = 0        
        WorkWithCurrFieldNo1.Validate(Age, WorkWithCurrFieldNo1.Age2); //CurrField = 0        
    end;
}
