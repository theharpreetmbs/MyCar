table 50000 "Car"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Car List";
    DrillDownPageId = "Car Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "VIN"; Code[30])
        {
            DataClassification = ToBeClassified;
            Unique = true;
        }
        field(3; "Make"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Model"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Owner Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Owner Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Owner Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Status"; Enum "Car Status")
        {
            DataClassification = ToBeClassified;
            InitValue = "In Inventory";
        }
        field(11; "Purchase Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Current Bay"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bay"."No.";
        }
        field(13; "Current Activity"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Mileage"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Insurance Company"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Insurance Company"."No.";
        }
        field(16; "Insurance Policy No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Last Service Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Next Service Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Color"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Engine Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Transmission"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Created By"; Code[50])
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
        key(VIN; "VIN")
        {
        }
        key(Status; "Status")
        {
        }
        key(CurrentBay; "Current Bay")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
    end;
}

enum 50000 "Car Status"
{
    Enum(0; "In Inventory")
    Enum(1; "Test Drive Scheduled")
    Enum(2; "Sold")
    Enum(3; "In Service")
    Enum(4; "Available for Pickup")
    Enum(5; "Picked Up")
    Enum(6; "Service Complete")
}
