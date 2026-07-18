report 50001 "Bay Utilization Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bay Utilization Report';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bay"; "Bay")
        {
            RequestFilterFields = "Bay Type", "Status";
            column(No_Bay; "No.")
            {
            }
            column(Description_Bay; "Description")
            {
            }
            column(BayType_Bay; "Bay Type")
            {
            }
            column(Status_Bay; "Status")
            {
            }
            column(CurrentCarNo_Bay; "Current Car No.")
            {
            }
            column(CurrentActivity_Bay; "Current Activity")
            {
            }
            column(UtilizationRate_Bay; "Utilization Rate")
            {
            }
            column(Location_Bay; "Location")
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
                    field(BayTypeFilter; BayTypeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Bay Type';
                        TableRelation = "Bay"."Bay Type";
                    }
                }
            }
        }
    }

    var
        BayTypeFilter: Text[50];
}
