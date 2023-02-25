1. Utworzono plik JS "UpdatePage.js" oraz "UpdateMain.js" w którym zaimplementowano potrzebne funkcje:
	- UpdatePage - której zadaniem jest wzbódzenie triggera na Page, w którym będzie osadzona kontrolka.
	- CallToJS - której zadaniem jest zadzwonienie do pliku JS wzbudzenie triggera na stronie który wyświetli komunikat (jest to dodatkowa nadmiarowa rzecz) + wywołanie funkcji UpdatePage
2. Utworzono Codeunit 50133 "Update Page From Table", z propercją SingleInstance = true w którym:
	- zadeklarowano zmienną globalną JSGlobal: ControlAddIn UpdatePage;
	- dodano funkcję SetControlAddIn(JS: ControlAddIn UpdatePage) mającą na celu przekazanie nszaej kontrolki do zmiennej globalnej JSGlobal
	- zadeklarowano funkcję RunUpdatePage() która ma na celu wywołanie na zmiennej globalnej JSGlobal funkcji CallToJS
3. Utworzono Table 50101 "Table Update Page From Table" w której zadeklarowano pola, w jednym z pól w trigerze OnLookup zadeklarowano zmienną CU: Codeunit "Update Page From Table", na której wywołujemy funkcję RunUpdatePage()
4. Utworzono Page 50104 "Update Page From Table" w którym dodano kontrolkę controladdin UpdatePage, zmienną globalną CU: Codeunit "Update Page From Table", natomiast w trigger OnAfterGetCurrRecord() na zmiennej globalnej
CU wywołano funkcję CU.SetControlAddIn(CurrPage.UpdatePage); dzięki czemu kopia naszej kontrolki z Page została przekazana do Codeunit

Teraz możemy w dowolnym miejscu zadeklarować zmienną  CU: Codeunit "Update Page From Table" i wywołać na niej CU.RunUpdatePage() co spowoduje zaktualizowanie naszego Page. Nawet jeżeli nasz Page będzie gdzie przykryty pod spodem.
Czyli dopóki żyje Nasza instancja obiektu Page i jest otwarta, nawet gdzieś pod spodem przykryta innymi oknami, to jak wrócimy do niej, zostanie ona odświeżona i dane zostaną zaktualizowane.