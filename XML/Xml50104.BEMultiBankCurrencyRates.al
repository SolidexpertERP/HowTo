xmlport 50104 "BE MultiBank Currency Rates"
{
    Caption = 'BE MultiBank Currency Rates';
    FieldSeparator = ';';
    RecordSeparator = '<LF>';
    FieldDelimiter = '';
    Format = VariableText;
    Direction = Import;
    UseRequestPage = false;
    TextEncoding = UTF8;

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(BMultiBankCurrencyRates; "BE MultiBank Currency Rates")
            {
                fieldattribute(field001; BMultiBankCurrencyRates.Field001)
                { }
                fieldattribute(field002; BMultiBankCurrencyRates.Field002)
                { }
                fieldattribute(field003; BMultiBankCurrencyRates.Field003)
                { }
                fieldattribute(field004; BMultiBankCurrencyRates.Field004)
                { }
                fieldattribute(field005; BMultiBankCurrencyRates.Field005)
                { }
                fieldattribute(field006; BMultiBankCurrencyRates.Field006)
                { }
                fieldattribute(field007; BMultiBankCurrencyRates.Field007)
                { }
                fieldattribute(field008; BMultiBankCurrencyRates.Field008)
                { }
            }
        }
    }
}
