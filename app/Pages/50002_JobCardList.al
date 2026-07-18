page 50002 "Job Card List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Card";
    CardPageId = "Job Card Card";
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
                field("Car No."; Rec."Car No.")
                {
                    ApplicationArea = All;
                }
                field("Car VIN"; Rec."Car VIN")
                {
                    ApplicationArea = All;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Assigned Technician"; Rec."Assigned Technician")
                {
                    ApplicationArea = All;
                }
                field("Labor Hours"; Rec."Labor Hours")
                {
                    ApplicationArea = All;
                }
                field("Total Estimated Cost"; Rec."Total Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field("Converted to Sales Order"; Rec."Converted to Sales Order")
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
            action("Create Job Card")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                trigger OnAction()
                begin
                    Page.Run(Page:"Job Card Card");
                end;
            }
        }
    }
}
