codeunit 50004 "Notification Engine"
{
    procedure NotifyCustomerOfScheduleChange(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        Car: Record "Car";
        NotificationMsg: Text[500];
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        if not Car.Get(Scheduler."Car No.") then exit;
        
        NotificationMsg := StrSubstNo('Your service schedule has been updated. Scheduled Pickup: %1 %2, Expected Delivery: %3 %4',
            Format(Scheduler."Scheduled Start Date"),
            Format(Scheduler."Scheduled Start Time"),
            Format(Scheduler."Expected Delivery Date"),
            Format(Scheduler."Expected Delivery Time"));
        
        SendEmailNotification(Car."Owner Email", 'Schedule Update - ' + Scheduler."Car No.", NotificationMsg);
        SendSMSNotification(Car."Owner Contact", NotificationMsg);
    end;

    procedure NotifyCustomerOfActivityCompletion(SchedulerNo: Code[20]; LineNo: Integer)
    var
        Scheduler: Record "Scheduler";
        SchedulerLine: Record "Scheduler Line";
        Car: Record "Car";
        NotificationMsg: Text[500];
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        if not SchedulerLine.Get(SchedulerNo, LineNo) then exit;
        if not Car.Get(Scheduler."Car No.") then exit;
        
        NotificationMsg := StrSubstNo('Activity completed: %1 in Bay %2. Next activity: Check scheduler for details.',
            SchedulerLine."Service Description",
            SchedulerLine."Assigned Bay");
        
        SendEmailNotification(Car."Owner Email", 'Activity Complete - ' + Scheduler."Car No.", NotificationMsg);
        SendSMSNotification(Car."Owner Contact", NotificationMsg);
    end;

    procedure NotifyCustomerOfBayLocation(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        Car: Record "Car";
        SchedulerLine: Record "Scheduler Line";
        NotificationMsg: Text[500];
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        if not Car.Get(Scheduler."Car No.") then exit;
        
        SchedulerLine.SetRange("Scheduler No.", SchedulerNo);
        SchedulerLine.SetRange("Activity Status", SchedulerLine."Activity Status"::"In Progress");
        
        if SchedulerLine.FindFirst() then
            NotificationMsg := StrSubstNo('Your car %1 is currently at Bay %2 for %3. Estimated completion: %4',
                Scheduler."Car No.",
                SchedulerLine."Assigned Bay",
                SchedulerLine."Service Description",
                Format(SchedulerLine."Scheduled End DateTime"))
        else
            NotificationMsg := 'Your car is in the queue. Please check the portal for bay location.';
        
        SendEmailNotification(Car."Owner Email", 'Car Location Update - ' + Scheduler."Car No.", NotificationMsg);
        SendSMSNotification(Car."Owner Contact", NotificationMsg);
    end;

    procedure NotifyReadyForPickup(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        Car: Record "Car";
        NotificationMsg: Text[500];
    begin
        if not Scheduler.Get(SchedulerNo) then exit;
        if not Car.Get(Scheduler."Car No.") then exit;
        
        NotificationMsg := StrSubstNo('Your car %1 is ready for pickup at Bay %2. Please collect it from %3.',
            Scheduler."Car No.",
            Scheduler."Dropoff Bay",
            Format(Scheduler."Expected Delivery Date") + ' ' + Format(Scheduler."Expected Delivery Time"));
        
        SendEmailNotification(Car."Owner Email", 'Car Ready for Pickup - ' + Scheduler."Car No.", NotificationMsg);
        SendSMSNotification(Car."Owner Contact", NotificationMsg);
    end;

    local procedure SendEmailNotification(EmailAddress: Text[100]; Subject: Text[200]; Body: Text[500])
    begin
        // Email integration will be implemented based on BC configuration
        // This is a placeholder for email service
        if EmailAddress <> '' then
            Message('Email would be sent to: %1 with subject: %2', EmailAddress, Subject);
    end;

    local procedure SendSMSNotification(PhoneNumber: Text[50]; Message: Text[500])
    begin
        // SMS integration will be implemented based on BC configuration
        // This is a placeholder for SMS service
        if PhoneNumber <> '' then
            Message('SMS would be sent to: %1', PhoneNumber);
    end;
}
