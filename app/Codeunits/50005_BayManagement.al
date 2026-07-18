codeunit 50005 "Bay Management"
{
    procedure AllocateBayToActivity(SchedulerNo: Code[20]; LineNo: Integer; BayNo: Code[20])
    var
        SchedulerLine: Record "Scheduler Line";
        Bay: Record "Bay";
    begin
        if not SchedulerLine.Get(SchedulerNo, LineNo) then
            Error('Scheduler line not found');
        
        if not Bay.Get(BayNo) then
            Error('Bay %1 not found', BayNo);
        
        if Bay."Status" <> Bay."Status"::"Available" then
            Error('Bay %1 is not available', BayNo);
        
        SchedulerLine."Assigned Bay" := BayNo;
        SchedulerLine.Modify(true);
        
        // Update bay status
        Bay."Status" := Bay."Status"::"In Use";
        Bay."Current Car No." := GetCarNoFromScheduler(SchedulerNo);
        Bay."Current Activity" := SchedulerLine."Service Description";
        Bay."Activity Start Time" := SchedulerLine."Scheduled Start DateTime";
        Bay."Activity End Time" := SchedulerLine."Scheduled End DateTime";
        Bay.Modify(true);
    end;

    procedure ReleaseBay(BayNo: Code[20])
    var
        Bay: Record "Bay";
    begin
        if not Bay.Get(BayNo) then
            Error('Bay %1 not found', BayNo);
        
        Bay."Status" := Bay."Status"::"Available";
        Bay."Current Car No." := '';
        Bay."Current Activity" := '';
        Bay."Activity Start Time" := 0DT;
        Bay."Activity End Time" := 0DT;
        Bay.Modify(true);
    end;

    procedure UpdateBayActivityProgress(BayNo: Code[20]; ProgressPercentage: Decimal)
    var
        Bay: Record "Bay";
    begin
        if not Bay.Get(BayNo) then
            Error('Bay %1 not found', BayNo);
        
        Bay."Utilization Rate" := ProgressPercentage;
        Bay.Modify(true);
    end;

    procedure GetAvailableBaysForServiceType(ServiceTypeCode: Code[20]): Record "Bay"
    var
        ServiceType: Record "Service Type";
        Bay: Record "Bay";
        Result: Record "Bay";
    begin
        if not ServiceType.Get(ServiceTypeCode) then
            Error('Service Type not found');
        
        Bay.SetRange("Bay Type", ServiceType."Assigned Bay Type");
        Bay.SetRange("Status", Bay."Status"::"Available");
        
        exit(Bay);
    end;

    local procedure GetCarNoFromScheduler(SchedulerNo: Code[20]): Code[20]
    var
        Scheduler: Record "Scheduler";
    begin
        if Scheduler.Get(SchedulerNo) then
            exit(Scheduler."Car No.")
        else
            exit('');
    end;
}
