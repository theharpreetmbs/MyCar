# BMW MyCar - Development Documentation

## Architecture Overview

### System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Business Central                         │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Presentations  │  │   Business Logic │  │   Data Access │  │
│  │   (Pages)    │  │   (Codeunits) │  │   (Tables)   │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Data Model

#### Core Tables

1. **Car** (50000)
   - Primary vehicle record
   - Stores VIN, make, model, owner info
   - Links to insurance companies
   - Tracks current bay location

2. **Job Card** (50001)
   - Service job details
   - Links to car and service type
   - Tracks technician assignment
   - Stores estimated/actual costs

3. **Bay** (50002)
   - Service bay configuration
   - Status tracking (Available/In Use/Maintenance)
   - Equipment and capacity info
   - Current car and activity

4. **Service Type** (50003)
   - Available services (Washing, Alignment, Painting, etc.)
   - Standard costs and durations
   - Required bay type
   - Service categories

5. **Scheduler** (50004)
   - Main schedule record
   - Links to car
   - Stores overall timeline
   - Total cost calculation
   - Expected delivery date

6. **Scheduler Line** (50005)
   - Individual activities in schedule
   - Sequence and timing
   - Assigned bay
   - Progress tracking
   - Actual vs. estimated costs

7. **Insurance Company** (50006)
   - Insurance partner configuration
   - Contact and payment terms
   - Default coverage percentage
   - Vendor link for invoicing

8. **Insurance Claim** (50007)
   - Claim records
   - Auto-calculated split amounts
   - Status workflow
   - Links to job cards and sales orders

### Relationships

```
Car (1) ──→ (M) Job Card
Car (1) ──→ (M) Scheduler
Car (1) ──→ (M) Insurance Claim

Job Card (1) ──→ (M) Scheduler
Job Card (1) ──→ (1) Sales Order

Service Type (1) ──→ (M) Scheduler Line
Bay (1) ──→ (M) Scheduler Line

Scheduler (1) ──→ (M) Scheduler Line
Scheduler (1) ──→ (1) Sales Order
Scheduler (1) ──→ (1) Insurance Claim

Insurance Company (1) ──→ (M) Insurance Claim
```

## Codeunit Architecture

### 50000 - Scheduler Management

**Key Procedures**:

```al
procedure CreateScheduler(CarNo, StartDate, StartTime, EndDate, EndTime): Code[20]
// Creates new scheduler record
// Returns: Scheduler No.

procedure AddActivityToScheduler(SchedulerNo, ServiceTypeCode, AssignedBay, Sequence, StartDateTime, EndDateTime)
// Adds activity line to scheduler
// Validates service type and bay
// Calculates costs

procedure RescheduleActivity(SchedulerNo, LineNo, NewStartDateTime, NewEndDateTime)
// Updates activity timing
// Auto-recalculates delivery dates
// Notifies sales order

procedure CheckConflicts(SchedulerNo, BayNo, StartDateTime, EndDateTime): Boolean
// Validates no overlapping activities
// Returns: true if conflict exists

procedure UpdateActivityProgress(SchedulerNo, LineNo, ProgressPercentage, ActivityStatus)
// Updates activity status and progress
// Sets actual start/end times
```

**Business Logic**:
- Automatic cost calculation from service types
- Expected delivery date updates
- Conflict detection and prevention
- Progress tracking with timestamps

### 50001 - Sales Order Integration

**Key Procedures**:

```al
procedure CreateSalesOrderFromScheduler(SchedulerNo): Code[20]
// Creates sales order from scheduler
// Adds line items from all activities
// Links to scheduler
// Returns: Sales Order No.

procedure SyncSchedulerToSalesOrder(SchedulerNo)
// Updates existing sales order
// Recalculates line items and amounts
// Updates expected delivery date

procedure UpdateSalesOrderFromInsuranceClaim(InsuranceClaimNo)
// Applies insurance split to sales order
// Updates payment amounts
```

**Business Logic**:
- Bi-directional sync with scheduler
- Automatic line item generation
- Cost aggregation from activities
- Customer auto-linking (can be extended)

### 50002 - Job Card Conversion

**Key Procedures**:

```al
procedure ConvertJobCardToSalesOrder(JobCardNo): Code[20]
// Converts job card to complete workflow
// Creates scheduler from job card
// Generates sales order
// Updates job card status
// Returns: Sales Order No.
```

**Workflow**:
1. Job Card created by technician
2. Conversion triggered
3. Scheduler created with activities
4. Sales Order generated
5. Car status updated to "In Service"
6. Sales Order ready for invoicing

### 50003 - Insurance Calculation

**Key Procedures**:

```al
procedure CalculateInsuranceSplit(ClaimAmount, CoveragePercentage): Record
// Calculates insurance vs. customer split
// Returns: Split record with both amounts

procedure CreateInsuranceAndCustomerInvoices(SchedulerNo, ClaimNo, TotalAmount)
// Creates two invoices:
//   1. Customer invoice (40%)
//   2. Insurance vendor invoice (60%)
// Returns: Both invoice numbers
```

**Business Logic**:
- Configurable split percentages
- Automatic invoice generation
- GL account mapping
- Vendor/Customer linking
- Payment terms application

### 50004 - Notification Engine

**Key Procedures**:

```al
procedure NotifyCustomerOfScheduleChange(SchedulerNo)
procedure NotifyCustomerOfActivityCompletion(SchedulerNo, LineNo)
procedure NotifyCustomerOfBayLocation(SchedulerNo)
procedure NotifyReadyForPickup(SchedulerNo)
```

**Notification Types**:
- Email notifications
- SMS notifications
- Portal messages (can be extended)
- Real-time alerts

### 50005 - Bay Management

**Key Procedures**:

```al
procedure AllocateBayToActivity(SchedulerNo, LineNo, BayNo)
// Assigns bay to activity
// Updates bay status
// Validates availability

procedure ReleaseBay(BayNo)
// Releases bay back to available pool
// Clears current car and activity

procedure UpdateBayActivityProgress(BayNo, ProgressPercentage)
// Updates bay utilization rate

procedure GetAvailableBaysForServiceType(ServiceTypeCode): Record Bay
// Returns available bays for service type
```

## Page Structure

### List Pages (Master)
- **50000**: Car List
- **50002**: Job Card List
- **50004**: Bay Management
- **50009**: Insurance Company List
- **50011**: Insurance Claim List
- **50013**: Service Type List

### Card Pages (Detail)
- **50001**: Car Card
- **50003**: Job Card Card
- **50005**: Bay Card
- **50006**: Scheduler Board (Calendar)
- **50007**: Scheduler Card
- **50010**: Insurance Company Card
- **50012**: Insurance Claim Card
- **50014**: Service Type Card

### Subpages (Parts)
- **50008**: Scheduler Line Subpage (Activities)

## API Integration Points

### External System Integration

The package is designed for integration with:

1. **Payment Gateways**
   - Method: `IntegrationManager` (to be created)
   - Sync: Sales order amounts
   - Fields: Invoice no, amount, payment status

2. **SMS/Email Services**
   - Method: `NotificationEngine` existing
   - Trigger: Schedule changes, completions
   - Templates: Customizable messages

3. **Insurance Systems**
   - Method: `InsuranceIntegration` (to be created)
   - Sync: Claim status, approval amounts
   - Fields: Policy no, claim ID, coverage %

4. **Customer Portal**
   - Method: OData API (built-in BC)
   - Expose: Scheduler, Car, Activity records
   - Fields: Location, progress, timeline

## Extensibility Points

### Adding New Service Types

1. Update Service Type table
2. Add to Service Category enum
3. Assign bay type in configuration
4. Create custom pricing if needed

### Custom Bay Types

1. Modify "Bay Type" enum
2. Update filtering in pages
3. Update service type assignments
4. Create utilization reports

### Additional Notifications

1. Add procedure to Notification Engine
2. Implement email/SMS logic
3. Create notification template
4. Trigger from relevant codeunit

### Insurance Integration

1. Create new "Insurance Integration" codeunit
2. Implement API calls
3. Update claim status automatically
4. Sync approval amounts

## Testing Strategy

### Unit Tests (Recommended)

```al
procedure TestCreateScheduler():
- Create car record
- Call CreateScheduler
- Assert: Scheduler created with correct dates

procedure TestActivityConflict():
- Create two overlapping activities
- Call CheckConflicts
- Assert: Conflict detected

procedure TestInsuranceSplit():
- Set claim amount 1000, coverage 60%
- Call CalculateInsuranceSplit
- Assert: Insurance 600, Customer 400
```

### Integration Tests

1. Job Card → Sales Order conversion
2. Schedule change → Sales Order update
3. Insurance claim → Invoice generation
4. Bay allocation → Availability check

### Performance Tests

1. Scheduler with 1000+ activities
2. Conflict detection with 500+ concurrent schedules
3. Report generation with 2+ years data
4. Invoice creation bulk processing

## Deployment Checklist

- [ ] All tables compiled without errors
- [ ] All pages render without errors
- [ ] All codeunits execute without errors
- [ ] Reports generate sample output
- [ ] Test data created successfully
- [ ] Security permissions configured
- [ ] Backup completed
- [ ] User training completed
- [ ] Support documentation deployed

## Maintenance & Support

### Regular Maintenance

- Monthly: Check for error logs
- Quarterly: Performance analysis
- Quarterly: Security audit
- Annually: Data archival

### Bug Reporting

Issue template:
```
**Title**: Brief description
**Steps to Reproduce**: 1. 2. 3.
**Expected**: What should happen
**Actual**: What actually happened
**Version**: Package version
**Environment**: BC version, tenant
```

## Version History

### v1.0.0 (Initial Release)
- Core scheduler functionality
- Job card to sales order conversion
- Insurance claim processing
- Bay management
- Notification system
- Basic reporting

### Future Enhancements (v1.1.0+)
- Mobile app integration
- Advanced analytics dashboard
- Payment gateway integration
- API for external systems
- Additional service types
- Custom reporting builder

---

**Document Version**: 1.0.0
**Last Updated**: 2026-07-18
