table 50002 "Bay"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Bay List";
    DrillDownPageId = "Bay Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Bay Type"; Enum "Bay Type")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Status"; Enum "Bay Status")
        {
            DataClassification = ToBeClassified;
            InitValue = "Available";
        }
        field(5; "Current Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Car"."No.";
        }
        field(6; "Current Activity"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Activity Start Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Activity End Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Capacity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Equipment List"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Last Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Utilization Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            MinValue = 0;
            MaxValue = 100;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Status; "Status")
        {
        }
        key(BayType; "Bay Type")
        {
        }
        key(CurrentCar; "Current Car No.")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Last Modified Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime;
    end;
}

enum 50002 "Bay Type"
{
    Enum(0; "General Service")
    Enum(1; "Wheel Alignment")
    Enum(2; "Painting")
    Enum(3; "Denting")
    Enum(4; "Washing")
    Enum(5; "Engine")
    Enum(6; "Electrical")
}

enum 50003 "Bay Status"
{
    Enum(0; "Available")
    Enum(1; "In Use")
    Enum(2; "Under Maintenance")
    Enum(3; "Out of Service")
}
