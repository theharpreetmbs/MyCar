report 50000 "Service Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Service Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/ServiceReport.rdl';

    dataset
    {
        dataitem("Scheduler"; "Scheduler")
        {
            RequestFilterFields = "Scheduled Start Date", "Car No.", "Status";
            column(No_Scheduler; "No.")
            {
            }
            column(CarNo_Scheduler; "Car No.")
            {
            }
            column(CarVIN_Scheduler; "Car VIN")
            {
            }
            column(OwnerName_Scheduler; "Owner Name")
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
            dataitem("Scheduler Line"; "Scheduler Line")
            {
                DataItemLink = "Scheduler No." = FIELD("No.");
                column(LineNo_SchedulerLine; "Line No.")
                {
                }
                column(ServiceDescription_SchedulerLine; "Service Description")
                {
                }
                column(AssignedBay_SchedulerLine; "Assigned Bay")
                {
                }
                column(ActivityStatus_SchedulerLine; "Activity Status")
                {
                }
                column(ScheduledStartDateTime_SchedulerLine; "Scheduled Start DateTime")
                {
                }
                column(ScheduledEndDateTime_SchedulerLine; "Scheduled End DateTime")
                {
                }
                column(EstimatedCost_SchedulerLine; "Estimated Cost")
                {
                }
                column(ProgressPercent_SchedulerLine; "Progress %")
                {
                }
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
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
}
