/// <summary>
/// https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/methods-auto/system/system-calcdate-string-date-method
/// </summary>
codeunit 50139 "Work With Date"
{
    /// <summary>
    /// Formatowanie daty do różnych formatów zgodnie z dokumentacją MS
    /// https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-format-property
    /// </summary>
    procedure FormatDate()
    var
        CurrentDateTime: DateTime;
        DateInTxt: Text;
    begin
        CurrentDateTime := System.CurrentDateTime;
        DateInTxt := Format(CurrentDateTime, 16, '<Day,2><Month Text,3><Year4>_<Hours24,2><Minutes,2><Seconds,2>');
        Message(DateInTxt);
    end;

    procedure CalculateDate()
    var
        EndDate: Date;
        StartDate: Date;
        ExprPreviousMonth: Label '<+CM>';
        ExprLast12Month: Label '<-CM-11M>'; // <->First Day <CM>Current Month - 10 <M>month
    begin
        EndDate := CalcDate(ExprPreviousMonth, 20230510D);
        StartDate := CalcDate(ExprLast12Month, EndDate);
        Message('Start Date: %1 \End Date: %2', StartDate, EndDate);
    end;

    procedure CalculateDate1()
    var
        EndDate: Date;
        StartDate: Date;
        ExprPreviousMonth: Label '<+CM-12M>';
        ExprLast12Month: Label '<-CM-11M>'; // <->First Day <CM>Current Month - 10 <M>month
    begin
        EndDate := CalcDate(ExprPreviousMonth, 20230510D);
        StartDate := CalcDate(ExprLast12Month, EndDate);
        Message('Start Date: %1 \End Date: %2', StartDate, EndDate);
    end;

    procedure CalculateDate2()
    var
        Expr1: Text[30];
        Expr2: Text[30];
        Expr3: Text[30];
        RefDate: Date;
        Date1: Date;
        Date2: Date;
        Date3: Date;
        RefDateTxt: Label 'The reference date is: %1 \\';
        Expr1Txt: Label 'The expression: %2 returns %3\\';
        Expr2Txt: Label 'The expression: %4 returns %5\\';
        Expr3Txt: Label 'The expression: %6 returns %7';
    begin
        Expr1 := '<CQ+1M-10D>'; // Current quarter + 1 month - 10 days  
        Expr2 := '<-WD2>'; // The last weekday no.2, (last Tuesday)  
        Expr3 := '<CM+30D>'; // Current month + 30 days  
        RefDate := 19960521D;
        Date1 := CalcDate(Expr1, RefDate);
        Date2 := CalcDate(Expr2, RefDate);
        Date3 := CalcDate(Expr3, RefDate);
        Message(RefDateTxt + Expr1Txt + Expr2Txt + Expr3Txt,
          RefDate, Expr1, Date1, Expr2, Date2, Expr3, Date3);
    end;

    /// <summary>
    /// Praca z dedykowaną tabelą licząca dni, miesiące, lata
    /// </summary>
    procedure LoopAfterMonth()
    var
        RecDate: Record Date;
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := 20221101D;
        EndDate := 20230801D;

        RecDate.RESET;
        RecDate.SETRANGE("Period Type", RecDate."Period Type"::Month);
        RecDate.SETRANGE("Period Start", StartDate, EndDate);
        if RecDate.FindSet() then
            repeat
                Message('%1 %2', RecDate."Period Start", RecDate."Period Name");
            until RecDate.Next() < 1;
    end;
}
