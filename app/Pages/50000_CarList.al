page 50000 "Car List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Car";
    CardPageId = "Car Card";
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
                field("VIN"; Rec."VIN")
                {
                    ApplicationArea = All;
                }
                field("Make"; Rec."Make")
                {
                    ApplicationArea = All;
                }
                field("Model"; Rec."Model")
                {
                    ApplicationArea = All;
                }
                field("Year"; Rec."Year")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                }
                field("Owner Contact"; Rec."Owner Contact")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Current Bay"; Rec."Current Bay")
                {
                    ApplicationArea = All;
                }
                field("Current Activity"; Rec."Current Activity")
                {
                    ApplicationArea = All;
                }
                field("Last Service Date"; Rec."Last Service Date")
                {
                    ApplicationArea = All;
                }
                field("Next Service Date"; Rec."Next Service Date")
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
            action("New Car")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = New;
                trigger OnAction()
                begin
                    Page.Run(Page:"Car Card");
                end;
            }
        }
    }
}
