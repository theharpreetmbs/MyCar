page 50009 "Insurance Company List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Insurance Company";
    CardPageId = "Insurance Company Card";

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
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Phone"; Rec."Phone")
                {
                    ApplicationArea = All;
                }
                field("Is Active"; Rec."Is Active")
                {
                    ApplicationArea = All;
                }
                field("Default Coverage %"; Rec."Default Coverage %")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 50010 "Insurance Company Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Insurance Company";
    Caption = 'Insurance Company Card';

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
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Insurance Company Code"; Rec."Insurance Company Code")
                {
                    ApplicationArea = All;
                }
                field("Is Active"; Rec."Is Active")
                {
                    ApplicationArea = All;
                }
                field("Default Coverage %"; Rec."Default Coverage %")
                {
                    ApplicationArea = All;
                }
            }
            group("Contact Information")
            {
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Phone"; Rec."Phone")
                {
                    ApplicationArea = All;
                }
            }
            group("Address")
            {
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                }
                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                }
                field("State"; Rec."State")
                {
                    ApplicationArea = All;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec."Country")
                {
                    ApplicationArea = All;
                }
            }
            group("Business Terms")
            {
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 50011 "Insurance Claim List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Insurance Claim";
    CardPageId = "Insurance Claim Card";

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
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                }
                field("Insurance Liable Amount"; Rec."Insurance Liable Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 50012 "Insurance Claim Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Insurance Claim";
    Caption = 'Insurance Claim Card';

    layout
    {
        area(Content)
        {
            group("Claim Information")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
            }
            group("Insurance Details")
            {
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Claim Details")
            {
                field("Claim Description"; Rec."Claim Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Job Card No."; Rec."Job Card No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Amount Calculation")
            {
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Insurance Coverage %"; Rec."Insurance Coverage %")
                {
                    ApplicationArea = All;
                }
                field("Insurance Liable Amount"; Rec."Insurance Liable Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Liable Amount"; Rec."Customer Liable Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Approval")
            {
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
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
            group("Notes")
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
