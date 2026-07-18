codeunit 50001 "Sales Order Integration"
{
    procedure CreateSalesOrderFromScheduler(SchedulerNo: Code[20]): Code[20]
    var
        Scheduler: Record "Scheduler";
        SchedulerLine: Record "Scheduler Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ServiceType: Record "Service Type";
        Item: Record "Item";
        Car: Record "Car";
        SalesOrderNo: Code[20];
        LineNo: Integer;
    begin
        if not Scheduler.Get(SchedulerNo) then
            Error('Scheduler %1 not found', SchedulerNo);
        
        if Scheduler."Sales Order No." <> '' then
            Error('Sales Order already exists for this scheduler');
        
        // Create Sales Header
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."Sell-to Customer No." := GetCustomerFromCar(Scheduler."Car No.");
        SalesHeader."Posting Date" := Today();
        SalesHeader."Order Date" := Today();
        SalesHeader."Expected Delivery Date" := Scheduler."Expected Delivery Date";
        SalesHeader.Insert(true);
        SalesOrderNo := SalesHeader."No.";
        
        // Add line items from scheduler
        SchedulerLine.SetRange("Scheduler No.", SchedulerNo);
        LineNo := 10000;
        
        if SchedulerLine.FindSet() then
            repeat
                if ServiceType.Get(SchedulerLine."Service Type Code") then begin
                    SalesLine.Init();
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := LineNo;
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                    SalesLine.Description := SchedulerLine."Service Description";
                    SalesLine.Quantity := 1;
                    SalesLine."Unit Price" := ServiceType."Total Standard Cost";
                    SalesLine."Line Amount" := ServiceType."Total Standard Cost";
                    SalesLine.Insert(true);
                    
                    LineNo += 10000;
                end;
            until SchedulerLine.Next() = 0;
        
        // Update scheduler with sales order reference
        Scheduler."Sales Order No." := SalesOrderNo;
        Scheduler.Modify(false);
        
        // Update car status
        if Car.Get(Scheduler."Car No.") then begin
            Car."Status" := Car."Status"::"In Service";
            Car.Modify(false);
        end;
        
        exit(SalesOrderNo);
    end;

    procedure SyncSchedulerToSalesOrder(SchedulerNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SchedulerLine: Record "Scheduler Line";
        ServiceType: Record "Service Type";
    begin
        if not Scheduler.Get(SchedulerNo) then
            Error('Scheduler %1 not found', SchedulerNo);
        
        if Scheduler."Sales Order No." = '' then
            Error('No Sales Order associated with this scheduler');
        
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, Scheduler."Sales Order No.") then
            Error('Sales Order %1 not found', Scheduler."Sales Order No.");
        
        // Update header expected delivery date
        SalesHeader."Expected Delivery Date" := Scheduler."Expected Delivery Date";
        SalesHeader.Modify(false);
        
        // Update line items
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", Scheduler."Sales Order No.");
        if SalesLine.FindSet() then
            repeat
                SalesLine.Delete(true);
            until SalesLine.Next() = 0;
        
        // Re-add lines from updated scheduler
        SchedulerLine.SetRange("Scheduler No.", SchedulerNo);
        SchedulerLine.SetCurrentKey("Activity Sequence");
        
        var
            LineNo: Integer;
        LineNo := 10000;
        
        if SchedulerLine.FindSet() then
            repeat
                if ServiceType.Get(SchedulerLine."Service Type Code") then begin
                    SalesLine.Init();
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := LineNo;
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                    SalesLine.Description := SchedulerLine."Service Description";
                    SalesLine.Quantity := 1;
                    SalesLine."Unit Price" := SchedulerLine."Estimated Cost";
                    SalesLine."Line Amount" := SchedulerLine."Estimated Cost";
                    SalesLine.Insert(true);
                    
                    LineNo += 10000;
                end;
            until SchedulerLine.Next() = 0;
    end;

    procedure UpdateSalesOrderFromInsuranceClaim(InsuranceClaimNo: Code[20])
    var
        InsuranceClaim: Record "Insurance Claim";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        if not InsuranceClaim.Get(InsuranceClaimNo) then
            Error('Insurance Claim %1 not found', InsuranceClaimNo);
        
        if InsuranceClaim."Sales Order No." = '' then
            Error('No Sales Order associated with this claim');
        
        if not SalesHeader.Get(SalesHeader."Document Type"::Order, InsuranceClaim."Sales Order No.") then
            Error('Sales Order %1 not found', InsuranceClaim."Sales Order No.");
        
        // Split the amount based on insurance coverage
        // This is handled by the Insurance Calculation codeunit
    end;

    local procedure GetCustomerFromCar(CarNo: Code[20]): Code[20]
    var
        Car: Record "Car";
    begin
        // In a real scenario, this would link cars to customers
        // For now, return a placeholder
        if Car.Get(CarNo) then
            exit('CUST001')
        else
            exit('');
    end;
}
