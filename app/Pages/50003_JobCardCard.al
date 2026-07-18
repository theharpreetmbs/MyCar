page 50003 "Job Card Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Job Card";
    Caption = 'Job Card';

    layout
    {
        area(Content)
        {
            group("Job Card Information")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Car Details")
            {
                field("Car No."; Rec."Car No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Car VIN"; Rec."Car VIN")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Owner Contact"; Rec."Owner Contact")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current Mileage"; Rec."Current Mileage")
                {
                    ApplicationArea = All;
                }
            }
            group("Service Details")
            {
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
            }
            group("Scheduling")
            {
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Start Time"; Rec."Scheduled Start Time")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End Time"; Rec."Scheduled End Time")
                {
                    ApplicationArea = All;
                }
                field("Assigned Technician"; Rec."Assigned Technician")
                {
                    ApplicationArea = All;
                }
            }
            group("Timing")
            {
                field("Actual Start Time"; Rec."Actual Start Time")
                {
                    ApplicationArea = All;
                }
                field("Actual End Time"; Rec."Actual End Time")
                {
                    ApplicationArea = All;
                }
                field("Labor Hours"; Rec."Labor Hours")
                {
                    ApplicationArea = All;
                }
            }
            group("Costing")
            {
                field("Labor Cost"; Rec."Labor Cost")
                {
                    ApplicationArea = All;
                }
                field("Parts Cost"; Rec."Parts Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Estimated Cost"; Rec."Total Estimated Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Insurance")
            {
                field("Is Insurance Claim"; Rec."Is Insurance Claim")
                {
                    ApplicationArea = All;
                }
                field("Insurance Claim No."; Rec."Insurance Claim No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Conversion")
            {
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Converted to Sales Order"; Rec."Converted to Sales Order")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {
        }
    }

    actions
    {
        area(Processing)
        {
            action("Convert to Sales Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Document;
                trigger OnAction()
                begin
                    Message('Job card will be converted to Sales Order');
                end;
            }
            action("Open Scheduler")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Calendar;
                trigger OnAction()
                begin
                    Message('Scheduler will open for this job card');
                end;
            }
        }
    }
}
