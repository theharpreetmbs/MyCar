page 50001 "Car Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Car";
    Caption = 'Car Card';

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
                field("VIN"; Rec."VIN")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Make"; Rec."Make")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Model"; Rec."Model")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Year"; Rec."Year")
                {
                    ApplicationArea = All;
                }
                field("Color"; Rec."Color")
                {
                    ApplicationArea = All;
                }
                field("Engine Type"; Rec."Engine Type")
                {
                    ApplicationArea = All;
                }
                field("Transmission"; Rec."Transmission")
                {
                    ApplicationArea = All;
                }
            }
            group("Registration")
            {
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Purchase Date"; Rec."Purchase Date")
                {
                    ApplicationArea = All;
                }
                field("Mileage"; Rec."Mileage")
                {
                    ApplicationArea = All;
                }
            }
            group("Owner Information")
            {
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Owner Contact"; Rec."Owner Contact")
                {
                    ApplicationArea = All;
                }
                field("Owner Email"; Rec."Owner Email")
                {
                    ApplicationArea = All;
                }
            }
            group("Service Status")
            {
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
            group("Insurance")
            {
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
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
            action("Create Service")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Message('Service booking page will open');
                end;
            }
            action("View Bay Tracker")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Message('Bay tracker page will open');
                end;
            }
        }
    }
}
