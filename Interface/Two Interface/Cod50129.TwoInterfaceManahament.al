/// <summary>
/// Codeunit implementujący 2x interfejsy. W pageextension 50101 "Ext Sales Quote" jest wywołanie tego Codeunit.
/// Sprawdzeniu zostało poddane, czy zmienna globalna GlobalVariable, ustawiona poprzez funkcję SetText z interfejsu "ISet Object" będzie dostępna
/// z poziomu drugiego interfejsu. Po sprawdzeniu okazało się, że globalna zmienna dostępna jest tak długo, jak długo trwa cykl życia Codeunit "Two Interface Manahament"
/// </summary>
codeunit 50129 "Two Interface Manahament" implements "IGet Object", "ISet Object"
{
    var
        GlobalVariable: Text;

    procedure GetText(var Variable: Text);
    begin
        Variable := GlobalVariable;
    end;

    procedure SetText(Variable: Text);
    begin
        GlobalVariable := Variable;
    end;
}
