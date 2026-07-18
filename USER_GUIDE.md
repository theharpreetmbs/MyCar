# BMW MyCar - User Guide

## Overview

BMW MyCar is a comprehensive Business Central AL package designed specifically for BMW dealership management. This guide covers all major features and how to use them effectively.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Managing Vehicles](#managing-vehicles)
3. [Service Scheduling](#service-scheduling)
4. [Job Cards](#job-cards)
5. [Scheduler & Calendar](#scheduler--calendar)
6. [Insurance Management](#insurance-management)
7. [Customer Portal](#customer-portal)
8. [Reports & Analytics](#reports--analytics)

## Getting Started

### Initial Access

1. Open Business Central
2. Search for "BMW MyCar" in the search bar
3. Select the desired module
4. You'll see the role-based dashboard

### User Roles

- **Service Manager**: Complete system access
- **Technician**: Job cards and activity tracking
- **Customer**: Portal access for tracking
- **Insurance Admin**: Claims management
- **Accountant**: Reports and financials

## Managing Vehicles

### Adding a New Vehicle

1. Go to **Car List** page
2. Click **New** to create a new car record
3. Fill in required fields:
   - **VIN**: Vehicle Identification Number
   - **Make**: BMW
   - **Model**: Series (e.g., 3 Series, 5 Series)
   - **Year**: Manufacturing year
   - **Registration Number**: License plate
   - **Owner Name**: Primary owner
   - **Owner Contact**: Phone number
   - **Owner Email**: Email address

4. Under **Service Status**:
   - Select **Status**: In Inventory, Test Drive, Sold, In Service
   - Assign **Insurance Company** if applicable
   - Enter **Insurance Policy No.**

5. Click **Save** to complete

### Viewing Vehicle Details

1. Open **Car List**
2. Click on any vehicle record to open **Car Card**
3. You can see:
   - Current bay location
   - Current activity being performed
   - Last and next service dates
   - Service history (via linked records)

### Updating Vehicle Status

1. Open car record
2. Change **Status** field:
   - **In Inventory**: Available for sale
   - **Test Drive Scheduled**: Booked for test drive
   - **Sold**: Car has been sold
   - **In Service**: Currently in service bay
   - **Available for Pickup**: Service complete, ready for pickup

## Service Scheduling

### Creating a Service Job

1. From **Car Card**, click **Create Service** button
2. Or go to **Job Card List** and click **New**

3. Fill in job card details:
   - **Car No.**: Auto-populated or select
   - **Service Type**: Select from dropdown (Washing, Alignment, Painting, etc.)
   - **Description**: Details about the service needed
   - **Scheduled Date**: When the service should happen
   - **Assigned Technician**: Who will perform the work

4. Enter costs:
   - **Labor Hours**: Estimated time
   - **Labor Cost**: Hourly rate × hours
   - **Parts Cost**: Expected parts expense
   - **Total Cost**: Auto-calculated

5. If insurance claim:
   - Check **Is Insurance Claim**
   - Link insurance claim record

6. Click **Save**

### Converting Job Card to Sales Order

1. Open **Job Card**
2. Click **Convert to Sales Order** button
3. System will:
   - Create scheduler entries
   - Assign bays automatically
   - Generate sales order
   - Update car status to "In Service"
4. Sales order appears in **Sales Order No.** field

## Job Cards

### Job Card Workflow

1. **Created**: Job card is created
2. **Scheduled**: Activities are scheduled
3. **In Progress**: Technician starts work
4. **Completed**: Service is finished
5. **Cancelled**: Service cancelled (if needed)

### Updating Job Card Progress

1. Open **Job Card**
2. Under **Timing** section:
   - Enter **Actual Start Time** when work begins
   - Enter **Actual End Time** when work completes
   - Update **Labor Hours** if different from estimate

3. Update costs if actual differs from estimate:
   - **Actual Labor Cost**
   - **Actual Parts Cost**

4. Change **Status** to "Completed"
5. Click **Save**

## Scheduler & Calendar

### Opening the Scheduler

1. Go to **Scheduler List** or **Scheduler Board**
2. Or click **Open Scheduler** from a **Sales Order** or **Job Card**

### Creating a Schedule

1. Click **New** to create scheduler record
2. Select **Car No.** - automatically fills car details
3. Set **Scheduled Start Date** and **Time**
4. Set **Scheduled End Date** and **Time**
5. Select **Pickup Bay** and **Dropoff Bay**

### Adding Activities to Schedule

1. In scheduler, go to **Activities** section
2. Click **Add Activity**
3. Fill in:
   - **Service Type**: Type of service
   - **Assigned Bay**: Which bay to use
   - **Scheduled Start DateTime**: When activity starts
   - **Scheduled End DateTime**: When activity ends
   - **Technician Assigned**: Who performs it

4. System auto-fills:
   - Service description
   - Estimated duration
   - Estimated cost

5. Click **Save**

### Calendar View

The scheduler provides a Microsoft Outlook-style calendar interface:

- **Monthly View**: See all scheduled activities
- **Weekly View**: Detailed view of activities
- **Drag & Drop**: Reschedule activities by dragging
- **Color Coding**: Different colors for service types
- **Conflict Detection**: Red flag for overlapping times

### Rescheduling Activities

**Via Calendar (Drag & Drop)**:
1. Click and drag activity to new time
2. System checks for conflicts
3. Updates automatically
4. Notification sent to customer

**Via Form**:
1. Open activity record
2. Modify **Scheduled Start DateTime**
3. Modify **Scheduled End DateTime**
4. Click **Reschedule** button
5. System updates:
   - Expected delivery date
   - Sales order timelines
   - Customer notifications

### Updating Activity Progress

1. Open activity in scheduler
2. Change **Activity Status**:
   - Pending → In Progress → Completed
3. Update **Progress %** field (0-100)
4. If status = "In Progress":
   - **Actual Start DateTime** auto-sets
5. If status = "Completed":
   - **Actual End DateTime** auto-sets
6. Save changes

### Expected Delivery Auto-calculation

The system automatically calculates:
- **Expected Delivery Date**: Last activity's end date
- **Expected Delivery Time**: Last activity's end time
- Updated on every activity change
- Synced to Sales Order

## Insurance Management

### Insurance Company Setup

1. Go to **Insurance Company List**
2. Click **New**
3. Fill in details:
   - **Name**: Insurance company name
   - **Contact Person**: Primary contact
   - **Email & Phone**: Contact information
   - **Address**: Company address
   - **Vendor No.**: Link to AP vendor
   - **Default Coverage %**: Typically 60%

4. Save and use when creating claims

### Creating Insurance Claim

1. Go to **Insurance Claim List**
2. Click **New**
3. Fill in:
   - **Car No.**: Select vehicle
   - **Claim Date**: Date of incident
   - **Insurance Company**: Select from list
   - **Claim Description**: Details
   - **Claim Amount**: Total damage/service cost
   - **Insurance Coverage %**: Usually 60%

4. System auto-calculates:
   - **Insurance Liable Amount**: 60% (example)
   - **Customer Liable Amount**: 40% (example)

5. If related to job card:
   - Link **Job Card No.**
   - Creates associated sales order

6. Click **Save**

### Claim Status Workflow

1. **Open**: Claim created
2. **Under Review**: Insurance reviewing
3. **Approved**: Fully approved
4. **Partial Approval**: Partially approved
5. **Rejected**: Not approved
6. **Paid**: Payment received
7. **Closed**: Claim completed

### Payment Split

When claim is approved:
- **Customer Invoice**: 40% of claim (can be configured)
- **Insurance Vendor Invoice**: 60% of claim (can be configured)

Both invoices are auto-generated with:
- Linked to original sales order
- Proper GL account coding
- Payment terms applied
- Ready for processing

## Customer Portal

### Accessing the Portal

1. Customer receives portal link via email
2. Login with provided credentials
3. View:
   - All owned vehicles
   - Current service status
   - Bay location (real-time)
   - Estimated completion time

### Tracking Service

1. Select vehicle from portal list
2. View current activity:
   - Service type being performed
   - Bay number/location
   - Technician assigned
   - Progress percentage
   - Estimated completion

3. View schedule:
   - Next activities
   - Expected duration
   - Estimated pickup date/time

### Notifications

Customers receive automatic notifications:
- **Activity Started**: "Service started in Bay 3"
- **Activity Completed**: "Wheel alignment complete, moving to next service"
- **Ready for Pickup**: "Your car is ready for pickup at Bay 1"
- **Schedule Changes**: "Your pickup time changed to 3 PM"

### Requesting Rescheduling

1. From portal, click **Reschedule Pickup**
2. Select new date and time
3. System checks availability
4. Submits change request
5. Manager approves/denies
6. Notification sent back to customer

## Reports & Analytics

### Available Reports

#### Service Report
- All services in date range
- Services by vehicle
- Services by technician
- Cost summary
- Activity status breakdown

**Access**: Reports → Service Report

#### Bay Utilization Report
- Bay occupancy by day/week/month
- Utilization percentage
- Current activity in each bay
- Downtime analysis
- Maintenance scheduling

**Access**: Reports → Bay Utilization Report

#### Insurance Claim Report
- All claims in period
- Claims by insurance company
- Approved vs. rejected
- Claim amounts and splits
- Payment status

**Access**: Reports → Insurance Claim Report

#### Scheduler Analysis Report
- Schedule compliance
- Activity completion rates
- Cost vs. budget analysis
- Time variance analysis
- Technician productivity

**Access**: Reports → Scheduler Analysis Report

### Running a Report

1. Search for report name
2. Click to open
3. Set filters:
   - Date range
   - Status
   - Specific cars/insurance companies

4. Click **Preview** to view
5. Click **Print** or **Export** for output
   - PDF export available
   - Excel export available
   - Email delivery option

## Tips & Best Practices

1. **Scheduling**: Create activities in sequence; system calculates delivery dates automatically
2. **Conflict Prevention**: System alerts if bay is already booked
3. **Cost Tracking**: Update actual costs as work progresses
4. **Customer Communication**: All schedule changes trigger notifications
5. **Insurance**: Link claims to job cards for automatic split invoicing
6. **Reporting**: Generate monthly reports to track performance

## Frequently Asked Questions

**Q: Can I reschedule multiple activities at once?**
A: Yes, modify dates and system will adjust all dependent activities.

**Q: What if a bay becomes unavailable?**
A: System alerts and suggests alternative bays based on service type.

**Q: How are customer and insurance amounts split?**
A: Default is 40/60; customizable per claim or globally in settings.

**Q: Can customers see their invoice details?**
A: Yes, portal shows itemized costs and payment schedule.

**Q: How do I handle delayed services?**
A: Reschedule in calendar; notifications auto-sent to customer.

---

**Need Help?** Contact your system administrator or check the Help section in Business Central.
