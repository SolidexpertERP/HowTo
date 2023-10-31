codeunit 50144 "Work With Number"
{
    /// <summary>
    /// Procedura do sprawdzenia jak działa odwrócenie znaków
    /// </summary>
    procedure ReverseSign()
    var
        NumberA: Decimal;
        RevNumberA: Decimal;
        NumberB: Decimal;
        RevNumberB: Decimal;
        Sum1: Decimal;
        Sum2: Decimal;
        MessageTxt: Text;
    begin
        NumberA := -1.00;
        NumberB := 3.00;
        RevNumberA := -NumberA; // RevNumberA = 1.00
        RevNumberB := -NumberB; // RevNumberB = -3.00
        Sum1 := NumberA + RevNumberA; // Sum1 = -1 + 1 = 0
        Sum2 := NumberB + RevNumberB; // Sum2 = 3 + -3 = 0
        MessageTxt += StrSubstNo('NumberA: %1\', NumberA);
        MessageTxt += StrSubstNo('NumberB: %1\', NumberB);
        MessageTxt += StrSubstNo('RevNumberA: %1\', RevNumberA);
        MessageTxt += StrSubstNo('RevNumberB: %1\', RevNumberB);
        MessageTxt += StrSubstNo('Sum1 := NumberA + RevNumberA = %1 + %2 = %3\', NumberA, RevNumberA, Sum1);
        MessageTxt += StrSubstNo('Sum2 := NumberB + RevNumberB = %1 + %2 = %3\', NumberB, RevNumberB, Sum2);
        Message(MessageTxt);
    end;
}
