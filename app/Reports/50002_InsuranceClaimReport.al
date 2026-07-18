report 50002 "Insurance Claim Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Insurance Claim Report';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Insurance Claim"; "Insurance Claim")
        {
            RequestFilterFields = "Claim Date", "Status", "Insurance Company";
            column(No_InsuranceClaim; "No.")
            {
            }
            column(CarNo_InsuranceClaim; "Car No.")
            {
            }
            column(CarVIN_InsuranceClaim; "Car VIN")
            {
            }
            column(OwnerName_InsuranceClaim; "Owner Name")
            {
            }
            column(InsuranceCompany_InsuranceClaim; "Insurance Company")
            {
            }
            column(ClaimDate_InsuranceClaim; "Claim Date")
            {
            }
            column(ClaimAmount_InsuranceClaim; "Claim Amount")
            {
            }
            column(InsuranceLiableAmount_InsuranceClaim; "Insurance Liable Amount")
            {
            }
            column(CustomerLiableAmount_InsuranceClaim; "Customer Liable Amount")
            {
            }
            column(Status_InsuranceClaim; "Status")
            {
            }
            column(InsuranceCoveragePercent_InsuranceClaim; "Insurance Coverage %")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(StatusFilter; StatusFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Status';
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        StatusFilter: Text[50];
}
