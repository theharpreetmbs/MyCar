table 50004 "Scheduler"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Scheduler List";
    DrillDownPageId = "Scheduler Card";

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
        field(6; "Scheduled Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Scheduled Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Scheduled End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Scheduled End Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Expected Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Expected Delivery Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Actual Start DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Actual End DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Status"; Enum "Scheduler Status")
        {
            DataClassification = ToBeClassified;
            InitValue = "Scheduled";
        }
        field(15; "Current Activity Index"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Pickup Bay"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bay"."No.";
        }
        field(17; "Dropoff Bay"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bay"."No.";
        }
        field(18; "Total Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Editable = false;
        }
        field(19; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Is Insurance Claim"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Insurance Claim No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Insurance Claim"."No.";
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
        key(ScheduledDate; "Scheduled Start Date")
        {
        }
        key(ExpectedDelivery; "Expected Delivery Date")
        {
        }
    }

    var
        Car: Record "Car";

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Modified Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
    end;
}

enum 50005 "Scheduler Status"
{
    Enum(0; "Draft")
    Enum(1; "Scheduled")
    Enum(2; "In Progress")
    Enum(3; "On Hold")
    Enum(4; "Completed")
    Enum(5; "Cancelled")
}
