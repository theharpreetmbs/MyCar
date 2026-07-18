table 50003 "Service Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Service Type List";
    DrillDownPageId = "Service Type Card";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Service Category"; Enum "Service Category")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Estimated Duration (Minutes)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Standard Labor Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(6; "Standard Parts Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(7; "Total Standard Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Editable = false;
        }
        field(8; "Assigned Bay Type"; Enum "Bay Type")
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(10; "Notes"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Category; "Service Category")
        {
        }
        key(Active; "Is Active")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Total Standard Cost" := "Standard Labor Cost" + "Standard Parts Cost";
    end;

    trigger OnModify()
    begin
        "Total Standard Cost" := "Standard Labor Cost" + "Standard Parts Cost";
    end;
}

enum 50004 "Service Category"
{
    Enum(0; "Washing")
    Enum(1; "Wheel Alignment")
    Enum(2; "Wheel Rotation")
    Enum(3; "Denting")
    Enum(4; "Painting")
    Enum(5; "Maintenance")
    Enum(6; "Repair")
    Enum(7; "Inspection")
}
