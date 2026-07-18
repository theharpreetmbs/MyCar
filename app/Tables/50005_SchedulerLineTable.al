table 50005 "Scheduler Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Scheduler No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Scheduler"."No.";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Activity Sequence"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Service Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Type"."Code";
            trigger OnValidate()
            begin
                if ServiceType.Get("Service Type Code") then begin
                    "Service Description" := ServiceType."Description";
                    "Estimated Duration (Minutes)" := ServiceType."Estimated Duration (Minutes)";
                    "Assigned Bay Type" := ServiceType."Assigned Bay Type";
                    "Estimated Cost" := ServiceType."Total Standard Cost";
                end;
            end;
        }
        field(5; "Service Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Assigned Bay"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bay"."No.";
        }
        field(7; "Assigned Bay Type"; Enum "Bay Type")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Scheduled Start DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Scheduled End DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Estimated Duration (Minutes)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Actual Start DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Actual End DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Activity Status"; Enum "Activity Status")
        {
            DataClassification = ToBeClassified;
            InitValue = "Pending";
        }
        field(14; "Technician Assigned"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Resource"."No.";
        }
        field(15; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(16; "Actual Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(17; "Progress %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(18; "Notes"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Scheduler No.", "Line No.")
        {
            Clustered = true;
        }
        key(Sequence; "Scheduler No.", "Activity Sequence")
        {
        }
        key(Status; "Activity Status")
        {
        }
        key(AssignedBay; "Assigned Bay")
        {
        }
    }

    var
        ServiceType: Record "Service Type";
}

enum 50006 "Activity Status"
{
    Enum(0; "Pending")
    Enum(1; "In Progress")
    Enum(2; "On Hold")
    Enum(3; "Completed")
    Enum(4; "Cancelled")
}
