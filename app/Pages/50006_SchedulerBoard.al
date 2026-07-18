page 50006 "Scheduler Board"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Scheduler";
    Caption = 'Scheduler Board';

    layout
    {
        area(Content)
        {
            group("Scheduler Calendar")
            {
                field("Scheduler Info"; 'Scheduler Board - Calendar View')
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
            }
        }
    }
}

page 50007 "Scheduler Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Scheduler";
    Caption = 'Scheduler';

    layout
    {
        area(Content)
        {
            group("Scheduler Information")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
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
            }
            group("Scheduling")
            {
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Scheduled Start Time"; Rec."Scheduled Start Time")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End Time"; Rec."Scheduled End Time")
                {
                    ApplicationArea = All;
                }
            }
            group("Expected Delivery")
            {
                field("Expected Delivery Date"; Rec."Expected Delivery Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Delivery Time"; Rec."Expected Delivery Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Bays")
            {
                field("Pickup Bay"; Rec."Pickup Bay")
                {
                    ApplicationArea = All;
                }
                field("Dropoff Bay"; Rec."Dropoff Bay")
                {
                    ApplicationArea = All;
                }
            }
            group("Financials")
            {
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
            group("Sales Order")
            {
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(SchedulerLine; "Scheduler Line Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Scheduler No." = FIELD("No.");
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
            action("Reschedule")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Calendar;
                trigger OnAction()
                begin
                    Message('Rescheduling interface will open');
                end;
            }
            action("Create Sales Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Document;
                trigger OnAction()
                begin
                    Message('Sales Order will be created from this scheduler');
                end;
            }
            action("Add Activity")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                Image = New;
                trigger OnAction()
                begin
                    Message('New activity will be added to scheduler');
                end;
            }
        }
    }
}

page 50008 "Scheduler Line Subpage"
{
    PageType = ListPart;
    SourceTable = "Scheduler Line";
    Caption = 'Activities';

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Activity Sequence"; Rec."Activity Sequence")
                {
                    ApplicationArea = All;
                }
                field("Service Type Code"; Rec."Service Type Code")
                {
                    ApplicationArea = All;
                }
                field("Service Description"; Rec."Service Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Assigned Bay"; Rec."Assigned Bay")
                {
                    ApplicationArea = All;
                }
                field("Assigned Bay Type"; Rec."Assigned Bay Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled Start DateTime"; Rec."Scheduled Start DateTime")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End DateTime"; Rec."Scheduled End DateTime")
                {
                    ApplicationArea = All;
                }
                field("Estimated Duration (Minutes)"; Rec."Estimated Duration (Minutes)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Activity Status"; Rec."Activity Status")
                {
                    ApplicationArea = All;
                }
                field("Progress %"; Rec."Progress %")
                {
                    ApplicationArea = All;
                }
                field("Technician Assigned"; Rec."Technician Assigned")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
