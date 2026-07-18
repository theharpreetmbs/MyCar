table 50007 "Insurance Claim"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Insurance Claim List";
    DrillDownPageId = "Insurance Claim Card";

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
                    "Insurance Company" := Car."Insurance Company";
                    "Insurance Policy No." := Car."Insurance Policy No.";
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
        field(5; "Insurance Company"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Insurance Company"."No.";
        }
        field(6; "Insurance Policy No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Claim Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Claim Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Claim Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
        }
        field(10; "Insurance Coverage %"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(11; "Insurance Liable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Editable = false;
        }
        field(12; "Customer Liable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;
            Editable = false;
        }
        field(13; "Status"; Enum "Claim Status")
        {
            DataClassification = ToBeClassified;
            InitValue = "Open";
        }
        field(14; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Notes"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Job Card No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Card"."No.";
        }
        field(19; "Sales Order No."; Code[20])
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
        key(InsuranceCompany; "Insurance Company")
        {
        }
        key(ClaimDate; "Claim Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        CalculateLiableAmounts();
    end;

    local procedure CalculateLiableAmounts()
    begin
        "Insurance Liable Amount" := "Claim Amount" * "Insurance Coverage %" / 100;
        "Customer Liable Amount" := "Claim Amount" - "Insurance Liable Amount";
    end;
}

enum 50007 "Claim Status"
{
    Enum(0; "Open")
    Enum(1; "Under Review")
    Enum(2; "Approved")
    Enum(3; "Rejected")
    Enum(4; "Partial Approval")
    Enum(5; "Paid")
    Enum(6; "Closed")
}
