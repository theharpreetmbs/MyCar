page 50013 "Service Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Service Type";
    CardPageId = "Service Type Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Service Category"; Rec."Service Category")
                {
                    ApplicationArea = All;
                }
                field("Estimated Duration (Minutes)"; Rec."Estimated Duration (Minutes)")
                {
                    ApplicationArea = All;
                }
                field("Assigned Bay Type"; Rec."Assigned Bay Type")
                {
                    ApplicationArea = All;
                }
                field("Standard Labor Cost"; Rec."Standard Labor Cost")
                {
                    ApplicationArea = All;
                }
                field("Standard Parts Cost"; Rec."Standard Parts Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Standard Cost"; Rec."Total Standard Cost")
                {
                    ApplicationArea = All;
                }
                field("Is Active"; Rec."Is Active")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 50014 "Service Type Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Service Type";
    Caption = 'Service Type Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Service Category"; Rec."Service Category")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Is Active"; Rec."Is Active")
                {
                    ApplicationArea = All;
                }
            }
            group("Scheduling")
            {
                field("Estimated Duration (Minutes)"; Rec."Estimated Duration (Minutes)")
                {
                    ApplicationArea = All;
                }
                field("Assigned Bay Type"; Rec."Assigned Bay Type")
                {
                    ApplicationArea = All;
                }
            }
            group("Pricing")
            {
                field("Standard Labor Cost"; Rec."Standard Labor Cost")
                {
                    ApplicationArea = All;
                }
                field("Standard Parts Cost"; Rec."Standard Parts Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Standard Cost"; Rec."Total Standard Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Additional Information")
            {
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}
