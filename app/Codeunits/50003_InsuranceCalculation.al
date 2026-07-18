codeunit 50003 "Insurance Calculation"
{
    procedure CalculateInsuranceSplit(ClaimAmount: Decimal; InsuranceCoveragePercentage: Decimal): Record "Insurance Claim Split"
    var
        InsuranceLiableAmount: Decimal;
        CustomerLiableAmount: Decimal;
        Split: Record "Insurance Claim Split";
    begin
        InsuranceLiableAmount := ClaimAmount * InsuranceCoveragePercentage / 100;
        CustomerLiableAmount := ClaimAmount - InsuranceLiableAmount;
        
        Split."Insurance Liable Amount" := InsuranceLiableAmount;
        Split."Customer Liable Amount" := CustomerLiableAmount;
        Split."Insurance Coverage %" := InsuranceCoveragePercentage;
        
        exit(Split);
    end;

    procedure CreateInsuranceAndCustomerInvoices(SchedulerNo: Code[20]; InsuranceClaimNo: Code[20]; TotalAmount: Decimal)
    var
        Scheduler: Record "Scheduler";
        InsuranceClaim: Record "Insurance Claim";
        InsuranceCompany: Record "Insurance Company";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        InsuranceAmount: Decimal;
        CustomerAmount: Decimal;
    begin
        if not Scheduler.Get(SchedulerNo) then
            Error('Scheduler %1 not found', SchedulerNo);
        
        if not InsuranceClaim.Get(InsuranceClaimNo) then
            Error('Insurance Claim %1 not found', InsuranceClaimNo);
        
        // Calculate split amounts
        InsuranceAmount := TotalAmount * InsuranceClaim."Insurance Coverage %" / 100;
        CustomerAmount := TotalAmount - InsuranceAmount;
        
        // Create customer sales invoice (40% or configured %)
        if CustomerAmount > 0 then
            CreateCustomerSalesInvoice(Scheduler, InsuranceClaim, CustomerAmount);
        
        // Create insurance vendor invoice (60% or configured %)
        if InsuranceAmount > 0 then
            CreateInsuranceVendorInvoice(Scheduler, InsuranceClaim, InsuranceAmount);
    end;

    procedure UpdateSchedulerWithInsuranceClaim(SchedulerNo: Code[20]; InsuranceClaimNo: Code[20])
    var
        Scheduler: Record "Scheduler";
        InsuranceClaim: Record "Insurance Claim";
    begin
        if not Scheduler.Get(SchedulerNo) then
            Error('Scheduler not found');
        
        if not InsuranceClaim.Get(InsuranceClaimNo) then
            Error('Insurance Claim not found');
        
        Scheduler."Is Insurance Claim" := true;
        Scheduler."Insurance Claim No." := InsuranceClaimNo;
        Scheduler.Modify(true);
    end;

    local procedure CreateCustomerSalesInvoice(Scheduler: Record "Scheduler"; InsuranceClaim: Record "Insurance Claim"; CustomerAmount: Decimal)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."Sell-to Customer No." := 'CUST001';
        SalesHeader."Posting Date" := Today();
        SalesHeader."Due Date" := CalcDate('<+30D>', Today());
        SalesHeader.Insert(true);
        
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := 10000;
        SalesLine.Type := SalesLine.Type::"G/L Account";
        SalesLine.Description := 'Service Charges - ' + Scheduler."Car No." + ' (Customer Share)';
        SalesLine.Quantity := 1;
        SalesLine."Unit Price" := CustomerAmount;
        SalesLine."Line Amount" := CustomerAmount;
        SalesLine.Insert(true);
    end;

    local procedure CreateInsuranceVendorInvoice(Scheduler: Record "Scheduler"; InsuranceClaim: Record "Insurance Claim"; InsuranceAmount: Decimal)
    var
        InsuranceCompany: Record "Insurance Company";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        if not InsuranceCompany.Get(InsuranceClaim."Insurance Company") then
            exit;
        
        if InsuranceCompany."Vendor No." = '' then
            exit;
        
        PurchaseHeader.Init();
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
        PurchaseHeader."Buy-from Vendor No." := InsuranceCompany."Vendor No.";
        PurchaseHeader."Posting Date" := Today();
        PurchaseHeader."Due Date" := CalcDate('<+30D>', Today());
        PurchaseHeader.Insert(true);
        
        PurchaseLine.Init();
        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
        PurchaseLine."Document No." := PurchaseHeader."No.";
        PurchaseLine."Line No." := 10000;
        PurchaseLine.Type := PurchaseLine.Type::"G/L Account";
        PurchaseLine.Description := 'Insurance Reimbursement - ' + Scheduler."Car No." + ' (Claim: ' + InsuranceClaim."No." + ')';
        PurchaseLine.Quantity := 1;
        PurchaseLine."Direct Unit Cost" := InsuranceAmount;
        PurchaseLine."Line Amount" := InsuranceAmount;
        PurchaseLine.Insert(true);
    end;
}
