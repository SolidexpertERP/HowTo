# **John Deere PMM Interface** - dokumentacja
## **Ogólny Opis**
Integracja mająca na celu raz w miesiącu wyeksportować plik `.dat` z danymi z poszczególnych magazynów (dokładny opis danych znajduje się w `Dedykowana tabela "JD PMM Interface Data"`). Wyznacznikiem, które magazyny mają brać udział w eksportowanych danych, będzie uzupełnienie pola `"Kartoteka lokalizacji"."Nr konta dealera JD"`, jeżeli to pole będzie posiadało dowolną wartość, oznaczać to będzie, że magazyn ma zostać uwzględniony w generowaniu danych. Mechanizm zostanie oparty na dedykowanej tabeli, Page reprezuntojącego dane z tabeli (bez możliwości ich edycji) oraz Codeunit z logiką biznesową. Cały mechanizm oraz wszystkie jego komponenty będą per firma. Mechanizm zostanie zainstalowany w firmie WS. Codeunit zostanie zamieszczony w harmonogramie i wywoływany cyklicznie (cykl do ustalenia). Codeunit będzie w pętli dla każdego magazynu wykonywał następujące czynności:
* zbierał dane dla określonego miesiąca i roku (dokładny sposób wyznaczania miesiąca będzie uzależniony od ustalenia interwału i czasu wyzwalania całego mechanizmu)
* tworzył wpisy za dany miesiąc do dedykowanej tabeli  `"JD PMM Interface Data"` (dla każdego magazynu odrębny wpis)
* generował plik dla rekordów nie wyeksportowanych, czyli tych z pustą datą w polu `"JD PMM Interface Data"."Record Processed"` - w trakcie generowania będą dokonywane wymagane obliczenia poszczególnych wartości które mają znaleźć się w pliku
* zamieszczał plik do wysyłki w dedykowanym i ustalonym do tego miescu.

Mechanizm nie będzie prowadził rejestru logu błędu oraz żadnych informacji związanych z brakiem przygotowanych danych dla danego magazynu. Każdy zapis dodawany do tabeli `"JD PMM Interface Data"` będzie wpisem per magazyn, oznaczony datą jego wygenerowania oraz datą wyeksportowania do pliku. Mechanizm nie przewiduje ręcznego wywoływania generowania danych dla zadanego miesiąca oraz roku. Mechanizm nie będzie sprawdzał, czy rekord pobierany do pliku jest poprawny, czyli czy jego dane takie jak rok oraz miesiąc mieszczą się w odpowiednim przedziale czasowym.

*************************************************************************************
## **Ważne pojęcia**
* ***Counter*** - zwykła sprzedaż z obszaru części
* ***Shop*** - wszystkie zlecenia `Job`
* ***Internal*** - zlecenia gwarancyjne, czyli te na których odbiorcą jest `John Deere`
* ***Hits*** - ilość wystąpień, czyli ile razy sprzedała się dana część (liczba rekordów `"Value Entry"` z filtrem na `z ilością zafakturowaną <>0 za dany miesiąc`)
* ***Zapas JD*** - wszystkie zapasy filtrowane wg. 
    - `Item."Make Code" = "BE Make Setup"."Code" (filtr "DTF Account No." <> '')`
    - `Item."MSE Item No." <> ''`
    - `Item."Catalog Item" = true`
* ***Last 12 (L12)*** - dla danych z maja 2023 r. = od czerwca 2022 r. do maja 2023 r.
* ***Prior 12 (P12)*** - dla danych z maja 2023 r. = od czerwca 2021 r. do maja 2022 r.
* ***Fill*** - oznacza, że cała ilość pozycji dla zamówienia pochodzi w 100% z magazynu, bez żadnych domówień z zewnątrz.
* ***Total Sales*** = Counter + Shop + Internal Sales – return from customer
* ***COS*** - Koszt sprzedaży / koszt towarów (= Średni koszt w JDPRism)
* ***PPP*** - Ilość w jednostce zakupu - "MSE Item"."Quantity Purchase Unit"
*************************************************************************************


## **Dedykowana tabela `"JD PMM Interface Data"`**
| Nr | Nazwa |  Typ |   Opis    | Źródło danych |
|----|-------|------|-----------|---------------|
|-|Nr Zapisu|Integer|`PK` - unikalny numer rekordu| `Klucz główny tabeli`|
|-|Rok|Code[4]|Rok za który są dane|Wartość generowana w momencie uruchomienia Codeunit / skryptu na podstawie daty uruchomienia|
|-|Miesiąc|Code[2]|Miesiąc za który są dane|Wartość generowana w momencie uruchomienia Codeunit / skryptu na podstawie daty uruchomienia|
|-|Kod DTF|Code[2]|Stała wartość `48` pobierana z dwóch pierwszych znaków `"Ustawienia Marki"."Nr konta DTF"`|2x pierwsze znaki `"BE Make Setup"."DTF Account No." (filtr Code = 'JOHN DEERE')`|
|-|Kod dostawcy|Code[6]|Nr kont DTF z ustawień marki `"Ustawienia Marki"."Nr konta DTF"`, dla marki JOHN DEERE czyli wartość `480461`|`"BE Make Setup"."DTF Account No." (filtr Code = 'JOHN DEERE')`|
|-|Kod magazynu|Code[4]|Kod magazynu JD (ostatnie 4x znaki) `"Kartoteka lokalizacji"."Nr konta dealera JD"`|4x ostatnie znaki `Location."JD Dealer Account No."`|
|-|Sales - Counter|Code[9]|Sprzedaż wszystkich części za dany miseiąc z kolumny "Miesiąc"| zafakturowane `"Value Entry" typ dokumnetu faktura sprzedaż, typ sprzedaż` 
|-|Sales - Shop|Code[9]|Wartość wszystkich zleceń serwisowych|`"Job Ledger Entry"."Wartość sprzedaży" z ilością ujemną (query na zapasy JD)`
|-|Sales - Internal|Code[9]|Wartość wszystkich zleceń gwarancyjnych. Na ustawieniach marki dodać 2x pola "Filtr gosp. gr ks. Sales Shop", "Filtr gosp gr. ks. Sales Internal"|`"Job Ledger Entry"."" z filtrami z ustawień marki`
|-|Return - Counter|Code[9]|Wartość wszystkich zwrotów z części|`zafakturowane "Value Entry" typ dokumnetu faktura korygująca, typ sprzedaż`
|-|Return - Shop|Code[9]|Wartość wszystkich zwrotów serwisowych|`"Job Ledger Entry"."Wartość sprzedaży" + z ilością dodatnią (query na zapasy JD)`
|-|Return - Internal|Code[x]|Wartość wszystkich zwrotów wewnętrznych|`"Job Ledger Entry"."Wartość sprzedaży" + z ilością dodatnią (query na zapasy JD) z odpowiednim filtrem grupy księgowej na ustawieniach marki`
|-|Current Inventory Value|Code[9]|Aktualna wartość magazynu|Suma kosztu rzeczywistego z Value Entry z filtrem na kod lokalizacji, zapas JD i datę księgowania Posting Date "..koniec miesiąca" czyli od początku świara do dnia wtwołania raportu.
|-|Total Part Sales - Month|Code[9]|Całkowita sprzedaż części z danego magazynu|` SPRAWDZIĆ WZÓR -> "Sales - Counter" + "Sales - Shop" + "Sales  - Internal" – ("Return - Counter" + "Return - Shop")`
|-|Total Parts COS – Month|Code[9]|Wartość COS wyliczana ze wzoru "Koszt sprzedaży / koszt towarów" (= Średni koszt w JDPRism) dla magazynu za dany miesiąc. Podczas sumowania poprzednich wartości od razu zapamiętywać te wartość i od razu dodajemy w to pole|`MSEItem."Purchase Price" / MSEItem."Quantity Purchase Unit"`
|-|No Sales Inventory|Code[9]|Całkowita aktualna wartość części dealera. Zapasy, które spełniają zakaz sprzedaży definicja znaleziona w Rozważaniach specjalnych na ten miesiąc.|`Mateusz Będzieszak`
|-|Counter – Stocked – Total Hits|Code[5]|Ilość wystąpnień zapasów JD na dokumentach sprzedaży, czyli ile razy na dokumentach sprzedaży pojawiły się zapasy JD|
|-|Counter – Stocked – 1st Pass Fills|Code[5]||
|-|Shop – Stocked – Total Hits|Code[5]||
|-|Shop – Stocked – 1st Pass Fills|Code[5]||
|-|Internal – Stocked – Total Hits|Code[5]||
|-|Internal – Stocked – 1st Pass Fills|Code[5]|Sprzedana w całości z magazynu bez domówień zewnętrznych|
|-|MTD Total Parts Return - Total|Code[9]|Całkowita wartość części zwróconych w tym miesiącu do działu części z licznika sprzedaż, sprzedaż sklepowa i sprzedaż wewnętrzna|`SPRAWDZIĆ WZÓR -> "Return - Counter" + "Return - Shop" + "Return - Internal"`
|-|Record Created|Date|Data utworzenia rekordu|
|-|Record Processed|Date|Data przetworzenia rekordu do pliku|
*************************************************************************************

## **Struktura pliku - sposób pozyskiwanych informacji do poszczególnych pól**
Przykładowa zawartość pliku (zapis dla jednego magazynu)
```
U484804610V2202305   P046100001665600001069700000169600000218-000000000      D1M
U48480461I           P046100000056-                                          D1M
U48480461J           P0461000277893000000000000986027001054656000028757      D1M
U48480461K           P0461000584207000624391000015889000272634000133333      D1M
U48480461L           P046100243002170000000000000000000000000000000000000000 D1M
U48480461M           P046100000000000001400005000000000000000000000000000000 D1M
U48480461N           P046100000000000000000000000950008100000000000000000000 D1M
U48480461O           P046100000000000000000000000000000000003000020000000000 D1M
U48480461P           P046100000000000000000000000000000000000000000003300032 D1M
U48480461Q           P046100000000000000000000000000000000000000000000000000 D1M
U48480461R           P046100001000000000000000000000000000000000000000000000 D1M
U48480461S           P04610000000000          00000187-                      D1M
U48480461T           P046100000000000000000000000000000000000000000000000000 D1M
U48480461U           P04610000000000                                         D1M
```
|Nazwa Pola|Oryginalny opis|Sekcja w której występuj|Źródło danych|
|----------|---------------|------------------------|-------------|
|PMMANAGE Record Code|Oryg. Opis|`U1,UI...`|Stała wartość `U`|
*************************************************************************************

## **Obiekty programistyczne wykorzystane w projekcie**
* Codeunit 50030 "JD PMM Interface Managament"c
* Tabela 50072 "BE JD PMM Interface Data"
* Page 
* Harmonogram zleceń
*************************************************************************************