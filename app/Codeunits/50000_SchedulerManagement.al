codeunit 50000 "Scheduler Management"
{
    procedure CreateScheduler(CarNo: Code[20]; StartDate: Date; StartTime: Time; EndDate: Date; EndTime: Time): Code[20]
    var
        Scheduler: Record "Scheduler";
        SchedulerNo: Code[20];
    begin
        SchedulerNo := GetNextSchedulerNo();
        
        Scheduler.Init();
        Scheduler."No." := SchedulerNo;
        Scheduler."Car No." := CarNo;
        Scheduler."Scheduled Start Date" := StartDate;
        Scheduler."Scheduled Start Time" := StartTime;
        Scheduler."Scheduled End Date" := EndDate;
        Scheduler."Scheduled End Time" := EndTime;
        Scheduler."Status" := Scheduler."Status"::"Draft";
        Scheduler.Insert(true);
        
        exit(SchedulerNo);
    end;

    procedure AddActivityToScheduler(SchedulerNo: Code[20]; ServiceTypeCode: Code[20]; AssignedBay: Code[20]; Sequence: Integer; StartDateTime: DateTime; EndDateTime: DateTime)
    var
        SchedulerLine: Record "Scheduler Line";
        ServiceType: Record "Service Type";
        LineNo: Integer;
    begin
        if not ServiceType.Get(ServiceTypeCode) then
            Error('Service Type %1 not found', ServiceTypeCode);
        
        LineNo := GetNextLineNo(SchedulerNo);
        
        SchedulerLine.Init();
        SchedulerLine."Scheduler No." := SchedulerNo;
        SchedulerLine."Line No." := LineNo;
        SchedulerLine."Activity Sequence" := Sequence;
        SchedulerLine."Service Type Code" := ServiceTypeCode;
        SchedulerLine."Service Description" := ServiceType."Description";
        SchedulerLine."Assigned Bay" := AssignedBay;
        SchedulerLine."Assigned Bay Type" := ServiceType."Assigned Bay Type";
        SchedulerLine."Scheduled Start DateTime" := StartDateTime;
        SchedulerLine."Scheduled End DateTime" := EndDateTime;
        SchedulerLine."Estimated Duration (Minutes)" := ServiceType."Estimated Duration (Minutes)";
        SchedulerLine."Estimated Cost" := ServiceType."Total Standard Cost";
        SchedulerLine."Activity Status" := SchedulerLine."Activity Status"::"Pending";
        SchedulerLine.Insert(true);
        
        UpdateSchedulerTotalCost(SchedulerNo);
        UpdateExpectedDeliveryDate(SchedulerNo);
    end;

    procedure RescheduleActivity(SchedulerNo: Code[20]; LineNo: Integer; NewStartDateTime: DateTime; NewEndDateTime: DateTime)
    var
        SchedulerLine: Record "Scheduler Line";
    begin
        if not SchedulerLine.Get(SchedulerNo, LineNo) then
            Error('Scheduler line not found');
        
        SchedulerLine."Scheduled Start DateTime" := NewStartDateTime;
        SchedulerLine."Scheduled End DateTime" := NewEndDateTime;
        SchedulerLine.Modify(true);
        
        UpdateSchedulerTotalCost(SchedulerNo);
        UpdateExpectedDeliveryDate(SchedulerNo);
        
        // Notify Sales Order of changes
        NotifySalesOrderOfScheduleChange(SchedulerNo);
    end;

    procedure ReschedulePickupDropoff(SchedulerNo: Code[20]; NewPickupBay: Code[20]; NewDropoffBay: Code[20]; NewDeliveryDate: Date; NewDeliveryTime: Time)
    var
        Scheduler: Record "Scheduler";
    begin
        if not Scheduler.Get(SchedulerNo) then
            Error('Scheduler not found');
        
        Scheduler."Pickup Bay" := NewPickupBay;
        Scheduler."Dropoff Bay" := NewDropoffBay;
        Scheduler."Expected Delivery Date" := NewDeliveryDate;
        Scheduler."Expected Delivery Time" := NewDeliveryTime;
        Scheduler.Modify(true);
        
        NotifySalesOrderOfScheduleChange(SchedulerNo);
    end;

    procedure UpdateActivityProgress(SchedulerNo: Code[20]; LineNo: Integer; ProgressPercentage: Decimal; ActivityStatus: Enum "Activity Status")
    var
        SchedulerLine: Record "Scheduler Line";
    begin
        if not SchedulerLine.Get(SchedulerNo, LineNo) then
            Error('Scheduler line not found');
        
        SchedulerLine."Progress %" := ProgressPercentage;
        SchedulerLine."Activity Status" := ActivityStatus;
        
        if ActivityStatus = SchedulerLine."Activity Status"::"In Progress" then
            SchedulerLine."Actual Start DateTime" := CurrentDateTime();
        
        if ActivityStatus = SchedulerLine."Activity Status"::"Completed" then
            SchedulerLine."Actual End DateTime" := CurrentDateTime();
        
        SchedulerLine.Modify(true);
    end;

    procedure CheckConflicts(SchedulerNo: Code[20]; BayNo: Code[20]; StartDateTime: DateTime; EndDateTime: DateTime): Boolean
    var
        SchedulerLine: Record "Scheduler Line";
        Bay: Record "Bay";
    begin
        if not Bay.Get(BayNo) then
            exit(false);
        
        SchedulerLine.SetCurrentKey("Assigned Bay");
        SchedulerLine.SetRange("Assigned Bay", BayNo);
        SchedulerLine.SetFilter("Scheduler No.", '<>%1', SchedulerNo);
        SchedulerLine.SetFilter("Activity Status", '<>%1', SchedulerLine."Activity Status"::"Cancelled");
        
        if SchedulerLine.FindSet() then
            repeat
                if not ((EndDateTime <= SchedulerLine."Scheduled Start DateTime") or 
                        (StartDateTime >= SchedulerLine."Scheduled End DateTime")) then
                    exit(true);
            until SchedulerLine.Next() = 0;
        
        exit(false);
    end;

    local procedure UpdateSchedulerTotalCost(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        SchedulerLine: Record "Scheduler Line";
        TotalCost: Decimal;
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        
        TotalCost := 0;
        SchedulerLine.SetRange("Scheduler No.", SchedulerNo);
        if SchedulerLine.FindSet() then
            repeat
                TotalCost += SchedulerLine."Estimated Cost";
            until SchedulerLine.Next() = 0;
        
        Scheduler."Total Estimated Cost" := TotalCost;
        Scheduler.Modify(false);
    end;

    local procedure UpdateExpectedDeliveryDate(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        SchedulerLine: Record "Scheduler Line";
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        
        SchedulerLine.SetRange("Scheduler No.", SchedulerNo);
        SchedulerLine.SetCurrentKey("Activity Sequence");
        SchedulerLine.Ascending(false);
        
        if SchedulerLine.FindFirst() then begin
            Scheduler."Expected Delivery Date" := DT2Date(SchedulerLine."Scheduled End DateTime");
            Scheduler."Expected Delivery Time" := DT2Time(SchedulerLine."Scheduled End DateTime");
        end;
        
        Scheduler.Modify(false);
    end;

    local procedure NotifySalesOrderOfScheduleChange(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        SalesOrderIntegration: Codeunit "Sales Order Integration";
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        if Scheduler."Sales Order No." <> '' then
            SalesOrderIntegration.SyncSchedulerToSalesOrder(SchedulerNo);
    end;

    local procedure GetNextSchedulerNo(): Code[20]
    var
        Scheduler: Record "Scheduler";
        NewNo: Code[20];
        NoSeries: Record "No. Series";
    begin
        // Simple implementation - in production use No. Series
        Scheduler.SetCurrentKey("No.");
        Scheduler.Ascending(false);
        if Scheduler.FindFirst() then
            NewNo := Format(StrToInt(Scheduler."No.") + 1)
        else
            NewNo := '1001';
        
        exit(CopyStr(NewNo, 1, MaxStrLen(Scheduler."No.")));
    end;

    local procedure GetNextLineNo(SchedulerNo: Code[20]): Integer
    var
        SchedulerLine: Record "Scheduler Line";
    begin
        SchedulerLine.SetRange("Scheduler No.", SchedulerNo);
        SchedulerLine.SetCurrentKey("Line No.");
        SchedulerLine.Ascending(false);
        if SchedulerLine.FindFirst() then
            exit(SchedulerLine."Line No." + 10000)
        else
            exit(10000);
    end;
}
