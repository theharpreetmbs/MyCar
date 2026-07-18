report 50003 "Scheduler Analysis Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Scheduler Analysis Report';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Scheduler"; "Scheduler")
        {
            RequestFilterFields = "Scheduled Start Date", "Status";
            column(No_Scheduler; "No.")
            {
            }
            column(CarNo_Scheduler; "Car No.")
            {
            }
            column(ScheduledStartDate_Scheduler; "Scheduled Start Date")
            {
            }
            column(ExpectedDeliveryDate_Scheduler; "Expected Delivery Date")
            {
            }
            column(Status_Scheduler; "Status")
            {
            }
            column(TotalEstimatedCost_Scheduler; "Total Estimated Cost")
            {
            }
            column(TotalActivityCount; TotalActivityCount)
            {
            }
            column(CompletedActivityCount; CompletedActivityCount)
            {
            }
            column(CompletionPercentage; CompletionPercentage)
            {
            }
            trigger OnAfterGetRecord()
            var
                SchedulerLine: Record "Scheduler Line";
            begin
                TotalActivityCount := 0;
                CompletedActivityCount := 0;
                
                SchedulerLine.SetRange("Scheduler No.", "No.");
                TotalActivityCount := SchedulerLine.Count();
                
                SchedulerLine.SetRange("Activity Status", SchedulerLine."Activity Status"::"Completed");
                CompletedActivityCount := SchedulerLine.Count();
                
                if TotalActivityCount > 0 then
                    CompletionPercentage := (CompletedActivityCount / TotalActivityCount) * 100
                else
                    CompletionPercentage := 0;
            end;
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
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        TotalActivityCount: Integer;
        CompletedActivityCount: Integer;
        CompletionPercentage: Decimal;
}
