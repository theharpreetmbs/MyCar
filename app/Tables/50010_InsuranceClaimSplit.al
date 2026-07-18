table 50010 "Insurance Claim Split"
{
    DataClassification = ToBeClassified;
    Temporary = true;

    fields
    {
        field(1; "Insurance Liable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer Liable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Insurance Coverage %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Insurance Liable Amount")
        {
            Clustered = true;
        }
    }
}
