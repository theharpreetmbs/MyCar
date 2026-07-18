codeunit 50002 "Job Card Conversion"
{
    procedure ConvertJobCardToSalesOrder(JobCardNo: Code[20]): Code[20]
    var
        JobCard: Record "Job Card";
        Scheduler: Record "Scheduler";
        SalesOrderIntegration: Codeunit "Sales Order Integration";
        SchedulerNo: Code[20];
        SalesOrderNo: Code[20];
    begin
        if not JobCard.Get(JobCardNo) then
            Error('Job Card %1 not found', JobCardNo);
        
        if JobCard."Converted to Sales Order" then
            Error('Job Card already converted to Sales Order');
        
        // Create scheduler from job card
        SchedulerNo := CreateSchedulerFromJobCard(JobCardNo);
        
        // Create sales order from scheduler
        SalesOrderNo := SalesOrderIntegration.CreateSalesOrderFromScheduler(SchedulerNo);
        
        // Update job card
        JobCard."Sales Order No." := SalesOrderNo;
        JobCard."Converted to Sales Order" := true;
        JobCard.Status := JobCard.Status::"Scheduled";
        JobCard.Modify(true);
        
        exit(SalesOrderNo);
    end;

    local procedure CreateSchedulerFromJobCard(JobCardNo: Code[20]): Code[20]
    var
        JobCard: Record "Job Card";
        Scheduler: Record "Scheduler";
        SchedulerManagement: Codeunit "Scheduler Management";
        SchedulerNo: Code[20];
        StartDateTime: DateTime;
        EndDateTime: DateTime;
    begin
        if not JobCard.Get(JobCardNo) then
            Error('Job Card not found');
        
        // Convert scheduled date/time to DateTime
        StartDateTime := CreateDateTime(JobCard."Scheduled Date", JobCard."Scheduled Start Time");
        EndDateTime := CreateDateTime(JobCard."Scheduled Date", JobCard."Scheduled End Time");
        
        // Create scheduler
        SchedulerNo := SchedulerManagement.CreateScheduler(
            JobCard."Car No.",
            JobCard."Scheduled Date",
            JobCard."Scheduled Start Time",
            JobCard."Scheduled Date",
            JobCard."Scheduled End Time"
        );
        
        // Add activity to scheduler
        if JobCard."Service Type" <> '' then
            SchedulerManagement.AddActivityToScheduler(
                SchedulerNo,
                JobCard."Service Type",
                '',  // Bay will be assigned later
                1,   // First activity
                StartDateTime,
                EndDateTime
            );
        
        exit(SchedulerNo);
    end;
}
