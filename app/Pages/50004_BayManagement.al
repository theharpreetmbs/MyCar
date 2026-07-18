page 50004 "Bay Management"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bay";
    CardPageId = "Bay Card";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Bay Type"; Rec."Bay Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Current Car No."; Rec."Current Car No.")
                {
                    ApplicationArea = All;
                }
                field("Current Activity"; Rec."Current Activity")
                {
                    ApplicationArea = All;
                }
                field("Activity Start Time"; Rec."Activity Start Time")
                {
                    ApplicationArea = All;
                }
                field("Activity End Time"; Rec."Activity End Time")
                {
                    ApplicationArea = All;
                }
                field("Utilization Rate"; Rec."Utilization Rate")
                {
                    ApplicationArea = All;
                }
                field("Location"; Rec."Location")
                {
                    ApplicationArea = All;
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
            action("New Bay")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                trigger OnAction()
                begin
                    Page.Run(Page:"Bay Card");
                end;
            }
        }
    }
}

page 50005 "Bay Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Bay";
    Caption = 'Bay Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Bay Type"; Rec."Bay Type")
                {
                    ApplicationArea = All;
                }
                field("Location"; Rec."Location")
                {
                    ApplicationArea = All;
                }
            }
            group("Status")
            {
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Current Car No."; Rec."Current Car No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current Activity"; Rec."Current Activity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Activity Start Time"; Rec."Activity Start Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Activity End Time"; Rec."Activity End Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Configuration")
            {
                field("Capacity"; Rec."Capacity")
                {
                    ApplicationArea = All;
                }
                field("Equipment List"; Rec."Equipment List")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Manager"; Rec."Manager")
                {
                    ApplicationArea = All;
                }
            }
            group("Performance")
            {
                field("Utilization Rate"; Rec."Utilization Rate")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
}
