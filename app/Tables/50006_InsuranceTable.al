table 50006 "Insurance Company"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Insurance Company List";
    DrillDownPageId = "Insurance Company Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Contact Person"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Phone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "City"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "State"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Postal Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Country"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Payment Terms"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms"."Code";
        }
        field(12; "Insurance Company Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(14; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor"."No.";
        }
        field(16; "Default Coverage %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            MinValue = 0;
            MaxValue = 100;
            InitValue = 60;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Active; "Is Active")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
    end;
}
