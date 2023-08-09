codeunit 50140 "Work With Temporary Table"
{
    var
        TempTable: Record "UV KPI Items" temporary;
        Item: Record Item;
        MyVar: Decimal;

    procedure CalculateData()
    begin
        ClearAll();

        if Item.FindSet() then
            repeat
                TempTable.Init();
                TempTable.No := Item."No.";
                TempTable.Amount := 1;
                TempTable.Insert();

                MyVar += 1;
            until Item.Next() < 1;

        TempTable.SetRange(No, '1896-SAAAAA');
        if not TempTable.IsEmpty then
            TempTable.Delete();


        TempTable.SetRange(No);
        TempTable.CalcSums(Amount);

        Message('TempTable.CalcSums(Amount): %1 \MyVar: %2', TempTable.Amount, MyVar);
    end;
}
