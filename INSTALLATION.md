# BMW MyCar - AL Package Installation Guide

## Installation Prerequisites

### System Requirements
- **Business Central**: Version 21.0 or later
- **AL Language Extension**: Latest version for VS Code
- **VS Code**: Version 1.60 or later
- **PowerShell**: Version 5.1 or later
- **.NET Framework**: 4.7.2 or later

### Required Extensions/Dependencies
- Business Central System Application
- Business Central Base Application
- Business Central Sales and Inventory Forecast (optional)

## Installation Steps

### Step 1: Prepare the Development Environment

1. Install VS Code from https://code.visualstudio.com/
2. Install the AL Language extension by Microsoft
3. Install PowerShell tools for VS Code (optional but recommended)

### Step 2: Clone the Repository

```bash
cd your-development-folder
git clone https://github.com/theharpreetmbs/MyCar.git
cd MyCar
```

### Step 3: Configure launch.json

1. Open the project in VS Code
2. Create `.vscode/launch.json` if it doesn't exist
3. Configure your Business Central instance:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "BC SandBox",
            "type": "al",
            "request": "launch",
            "server": "https://bc.businesscentral.dynamics.com",
            "authentication": "AAD",
            "tenant": "your-tenant-id",
            "breakOnError": true,
            "breakOnNext": false,
            "launchBrowser": true,
            "enableLongRunningSqlStatements": true,
            "enableSqlInformationDebugger": true,
            "httpHeadersFile": "./headers.json",
            "startupObjectId": 50000,
            "startupObjectType": "Page",
            "al.codeAnalyzers": [
                "${CodeAnalyzersFolder}\\Microsoft.Dynamics.Nav.CodeAnalyzers.dll"
            ]
        }
    ]
}
```

### Step 4: Build and Compile

1. Press `Ctrl + Shift + B` to build the project
2. Resolve any compilation errors
3. The build output will be in the `bin` folder

### Step 5: Deploy to Business Central

1. Press `Ctrl + Shift + D` to deploy
2. Alternatively, publish manually:

```powershell
# From the project root directory
al-go build
al-go deploy
```

### Step 6: Initial Setup in Business Central

1. Go to **BMW MyCar Setup**
2. Configure:
   - **Service Types**: Add your service offerings
   - **Bays**: Register all service bays with locations
   - **Insurance Companies**: Add insurance partner details
   - **Pricing Matrix**: Set labor and parts costs

## Configuration Guide

### Service Types Setup

1. Navigate to **Service Type List**
2. Create new service types:
   - **Code**: Unique identifier (e.g., WASH, ALIGN, PAINT)
   - **Description**: Full name of the service
   - **Category**: Select from predefined categories
   - **Estimated Duration**: In minutes
   - **Bay Type**: Assign appropriate bay type
   - **Labor Cost**: Standard labor charges
   - **Parts Cost**: Average parts cost

### Bay Configuration

1. Navigate to **Bay Management**
2. Add bays with details:
   - **Bay Number**: Unique identifier
   - **Description**: Bay name/location
   - **Bay Type**: Service type (Washing, Alignment, etc.)
   - **Location**: Physical location in workshop
   - **Capacity**: Number of cars simultaneously
   - **Equipment**: List of available equipment

### Insurance Company Setup

1. Navigate to **Insurance Company List**
2. Add insurance partners:
   - **Name**: Insurance company name
   - **Contact Person**: Primary contact
   - **Payment Terms**: Standard terms
   - **Default Coverage %**: Default split (typically 60%)
   - **Vendor Number**: Link to AP vendor (for invoicing)

## User Workflows

### Workflow 1: Car Test Drive & Sale

1. **Create Car Record**
   - Go to **Car List**
   - Create new car with VIN, make, model, owner details
   - Set status to "Test Drive Scheduled"

2. **Schedule Test Drive**
   - Use **Scheduler** to book drive
   - Assign bay for preparation
   - Set date and time

3. **Mark as Sold**
   - Update Car status to "Sold"
   - Record owner information
   - Assign insurance company

### Workflow 2: Service Booking & Scheduling

1. **Create Job Card**
   - Go to **Job Card List**
   - Select car and service type
   - Enter description and expected duration

2. **Schedule in Calendar**
   - Open **Scheduler**
   - Add activities with time slots
   - Assign bays automatically or manually
   - System checks for conflicts

3. **Create Sales Order**
   - Click "Convert to Sales Order"
   - System auto-generates SO from scheduler
   - Cost is calculated based on services

### Workflow 3: Real-time Tracking

1. **Customer Portal Access**
   - Provide customer with tracking link
   - Show current bay location
   - Display current activity
   - Show estimated completion time

2. **Update Activity Progress**
   - Technician updates progress % in scheduler
   - Change activity status to "In Progress"
   - Mark complete when done

3. **Dynamic Rescheduling**
   - Adjust times if activities take longer
   - Automatically updates Sales Order
   - Notification sent to customer

### Workflow 4: Insurance Claims

1. **Create Claim**
   - Go to **Insurance Claim List**
   - Select car and insurance company
   - Enter claim details and amount

2. **Automatic Split Calculation**
   - System calculates 40% customer / 60% insurance
   - Two invoices are generated:
     - Customer invoice for 40%
     - Insurance vendor invoice for 60%

3. **Approval & Payment**
   - Insurance company reviews and approves
   - Update claim status
   - Process payments accordingly

## Key Features Usage

### Calendar-like Scheduler

- Visual Outlook-style calendar interface
- Drag-and-drop activity rescheduling
- Color-coded bay types
- Real-time conflict detection
- Time progression with tick marks

### Bay Tracker

- Shows all active bays
- Current car in each bay
- Activity being performed
- Remaining time estimate
- Customer notification triggers

### Payment Split

Automatic calculation:
- **Total Amount**: Full service cost
- **Customer Share**: 40% (configurable per claim)
- **Insurance Share**: 60% (configurable per claim)
- Separate invoicing for each party

## Reporting

### Available Reports

1. **Service Report**
   - All services by date range
   - Details by car and technician
   - Cost summary

2. **Bay Utilization Report**
   - Bay occupancy by time period
   - Utilization rates
   - Maintenance schedules

3. **Insurance Claim Report**
   - Claims by insurance company
   - Claim amounts and splits
   - Approval status

4. **Scheduler Analysis Report**
   - Activity completion rates
   - Schedule compliance
   - Cost vs. budget

## Troubleshooting

### Common Issues

**Issue**: Compilation errors with table relationships
- **Solution**: Ensure all table dependencies are resolved; rebuild the project

**Issue**: Bay conflicts detected when scheduling
- **Solution**: Check existing schedules; use Bay Utilization Report to find available bays

**Issue**: Scheduler not syncing to Sales Order
- **Solution**: Verify Sales Order creation completed successfully; check integration logs

**Issue**: Insurance split not calculating correctly
- **Solution**: Verify coverage % in Insurance Claim; check calculation formula

## Customization Guidelines

### Adding Custom Service Types

1. Add entry to Service Type table
2. Update Service Category enum if needed
3. Assign to appropriate bay type
4. Set labor and parts costs

### Extending Bay Types

1. Modify "Bay Type" enum in BayTable.al
2. Add new page field controls
3. Update filtering in related pages

### Custom Notifications

1. Edit Notification Engine codeunit
2. Modify email/SMS templates
3. Add custom notification triggers

## Performance Optimization

### Database Indexes

Key indexes are already configured on:
- Car by Status
- Scheduler by Car No. and Status
- Scheduler Line by Activity Status
- Bay by Status

### Query Optimization

- Use provided queries for reporting
- Avoid unnecessary joins in custom queries
- Use SetRange for filtering large datasets

## Security Considerations

### User Permissions

1. **Service Manager**: Full access to all modules
2. **Technician**: Job card and scheduler access
3. **Customer**: Portal view only
4. **Insurance Admin**: Claim management
5. **Accountant**: Financial reports only

### Data Protection

- Customer data encrypted at rest
- Insurance policy numbers secured
- Activity logs maintained for audit
- Role-based access control enabled

## Support & Maintenance

### Regular Maintenance

- Quarterly data backups
- Monthly report reviews
- Quarterly performance tuning
- Annual security audit

### Version Updates

- Check GitHub for latest releases
- Review changelog before updating
- Test in sandbox first
- Deploy during maintenance window

## Additional Resources

- [Business Central Documentation](https://docs.microsoft.com/en-us/dynamics365/business-central/)
- [AL Language Reference](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview)
- [GitHub Repository](https://github.com/theharpreetmbs/MyCar)

---

**Last Updated**: 2026-07-18
**Version**: 1.0.0
