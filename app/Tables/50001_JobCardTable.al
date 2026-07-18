table 50001 "Job Card"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Job Card List";
    DrillDownPageId = "Job Card Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Car No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Car"."No.";
            trigger OnValidate()
            begin
                if Car.Get("Car No.") then begin
                    "Car VIN" := Car."VIN";
                    "Owner Name" := Car."Owner Name";
                    "Owner Contact" := Car."Owner Contact";
                    "Current Mileage" := Car."Mileage";
                end;
            end;
        }
        field(3; "Car VIN"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Owner Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Service Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Type"."Code";
        }
        field(7; "Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Assigned Technician"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Resource"."No.";
        }
        field(9; "Status"; Enum "Job Card Status")
        {
            DataClassification = ToBeClassified;
            InitValue = "Open";
        }
        field(10; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Scheduled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Scheduled Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Scheduled End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Actual Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Actual End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Labor Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(17; "Labor Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(18; "Parts Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(19; "Total Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Editable = false;
        }
        field(20; "Current Mileage"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Is Insurance Claim"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Insurance Claim No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Insurance Claim"."No.";
        }
        field(23; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Converted to Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(CarNo; "Car No.")
        {
        }
        key(Status; "Status")
        {
        }
        key(ScheduledDate; "Scheduled Date")
        {
        }
    }

    var
        Car: Record "Car";

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
    end;
}

enum 50001 "Job Card Status"
{
    Enum(0; "Open")
    Enum(1; "Scheduled")
    Enum(2; "In Progress")
    Enum(3; "Completed")
    Enum(4; "Cancelled")
    Enum(5; "On Hold")
}
