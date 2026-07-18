# BMW Dealer Management System - MyCar

## Overview
A comprehensive Business Central AL package for BMW dealership management, providing integrated vehicle service management, scheduling, and sales operations.

## Core Features

### 1. **Car Test Drive / Sale System**
- Test drive booking and management
- Vehicle sales tracking
- Customer interaction history
- Inventory management

### 2. **Service Management**
- Service booking for sold cars
- Service status tracking
- Service completion workflows
- Technician assignment

### 3. **Job Card Management**
- Detailed job card creation
- Technician assignment
- Labor hour tracking
- Cost estimation

### 4. **Job Card to Sales Order Conversion**
- Automatic conversion from job cards
- Line item mapping
- Cost estimation and calculation
- Service charge application

### 5. **Bay Location Management**
- Bay registration and configuration
- Bay availability tracking
- Real-time bay status
- Bay capacity management

### 6. **Service Types**
- Washing
- Wheel Alignments
- Wheel Rotation
- Denting
- Painting
- Custom service support
- Service pricing matrix

### 7. **Scheduler Matrix**
- Dynamic service scheduling
- Time slot management
- Capacity planning
- Resource allocation

### 8. **Customer Car Bay Tracking**
- Real-time bay location visibility
- Current activity display
- Status notifications
- Activity progress tracking

### 9. **Pickup/Drop-off Rescheduling**
- User-friendly reschedule interface
- Calendar-based date/time selection
- Automatic conflict detection
- Notification system

### 10. **Dynamic Activity Time Adjustment**
- Real-time time modification
- Activity duration adjustment
- Automatic propagation to dependent activities
- Impact analysis

### 11. **Automatic Sales Order Updates**
- Scheduler changes sync to Sales Orders
- Amount recalculation
- Status synchronization
- Real-time line item updates

### 12. **Sales Order Scheduler Integration**
- Open scheduler directly from Sales Order
- Activity and bay selection
- Quick activity addition/modification
- Bidirectional sync

### 13. **Expected Delivery Auto-calculation**
- Dynamic delivery date calculation
- Current activity tracking
- Status bar updates
- Estimated completion time

### 14. **Calendar-like Scheduler Interface**
- Microsoft Outlook calendar UI
- Date/time selection
- Visual time progression
- Activity tick progress indicator
- Drag-and-drop scheduling

### 15. **Insurance Management**
- Insurance claim tracking
- Policy integration
- Payment split calculation (40% Customer / 60% Insurance)
- Insurance party billing
- Claim document management

## Repository Structure

```
MyCar/
├── app/
│   ├── Tables/
│   │   ├── 50000_CarTable.al
│   │   ├── 50001_JobCardTable.al
│   │   ├── 50002_BayTable.al
│   │   ├── 50003_ServiceTypeTable.al
│   │   ├── 50004_SchedulerTable.al
│   │   ├── 50005_SchedulerLineTable.al
│   │   ├── 50006_InsuranceTable.al
│   │   ├── 50007_InsuranceClaimTable.al
│   │   ├── 50008_ServiceLineTable.al
│   │   └── 50009_BayActivityTable.al
│   ├── Pages/
│   │   ├── 50000_CarList.al
│   │   ├── 50001_CarCard.al
│   │   ├── 50002_JobCardList.al
│   │   ├── 50003_JobCardCard.al
│   │   ├── 50004_BayManagement.al
│   │   ├── 50005_SchedulerBoard.al
│   │   ├── 50006_SchedulerCard.al
│   │   ├── 50007_ServiceManagement.al
│   │   ├── 50008_InsuranceManagement.al
│   │   ├── 50009_CustomerPortal.al
│   │   ├── 50010_BayTracker.al
│   │   └── 50011_InsuranceClaimManagement.al
│   ├── Codeunits/
│   │   ├── 50000_SchedulerManagement.al
│   │   ├── 50001_SalesOrderIntegration.al
│   │   ├── 50002_JobCardConversion.al
│   │   ├── 50003_InsuranceCalculation.al
│   │   ├── 50004_NotificationEngine.al
│   │   ├── 50005_BayManagement.al
│   │   └── 50006_ReportGeneration.al
│   ├── Reports/
│   │   ├── 50000_ServiceReport.al
│   │   ├── 50001_BayUtilizationReport.al
│   │   ├── 50002_InsuranceClaimReport.al
│   │   └── 50003_SchedulerAnalysis.al
│   ├── Queries/
│   │   ├── 50000_BayOccupancyQuery.al
│   │   └── 50001_ServiceStatusQuery.al
│   └── app.json
├── .gitignore
└── README.md
```

## Technology Stack
- **AL Language** - Business Central customization
- **Business Central** - Cloud/On-Premises ERP
- **SQL Server** - Database backend
- **Power BI** - Advanced analytics (optional)

## Key Objects Overview

### Tables (50000-50009)
- **CarTable**: Vehicle inventory and details
- **JobCardTable**: Job card master records
- **BayTable**: Service bay configuration
- **ServiceTypeTable**: Available service types
- **SchedulerTable**: Scheduler master records
- **SchedulerLineTable**: Scheduler activities and time slots
- **InsuranceTable**: Insurance company details
- **InsuranceClaimTable**: Insurance claim tracking
- **ServiceLineTable**: Service line items
- **BayActivityTable**: Current bay activities and status

### Pages (50000-50011)
- **CarList/Card**: Manage vehicles
- **JobCardList/Card**: Create and manage job cards
- **BayManagement**: Configure and monitor bays
- **SchedulerBoard**: Visual scheduler interface
- **ServiceManagement**: Service booking and tracking
- **InsuranceManagement**: Insurance configuration
- **CustomerPortal**: Customer-facing portal
- **BayTracker**: Real-time bay location tracking
- **InsuranceClaimManagement**: Claims processing

### Codeunits (50000-50006)
- **SchedulerManagement**: Core scheduling logic and conflicts
- **SalesOrderIntegration**: Sync between scheduler and sales orders
- **JobCardConversion**: Convert job cards to sales orders
- **InsuranceCalculation**: Split payment calculations
- **NotificationEngine**: Customer and staff notifications
- **BayManagement**: Bay allocation and tracking
- **ReportGeneration**: Report generation and exports

### Reports (50000-50003)
- **ServiceReport**: Service history and details
- **BayUtilizationReport**: Bay usage analytics
- **InsuranceClaimReport**: Insurance claim summaries
- **SchedulerAnalysis**: Scheduler performance metrics

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/theharpreetmbs/MyCar.git
   ```

2. **Install Business Central development environment**
   - Install Business Central (Cloud or On-Premises)
   - Install AL Language extension in VS Code

3. **Configure AL Language extension**
   - Open VS Code
   - Install AL Language extension by Microsoft
   - Configure launch.json with your Business Central instance

4. **Build and Deploy**
   ```bash
   # Build the project
   al build
   
   # Deploy to Business Central
   al deploy
   ```

5. **Run Initial Setup**
   - Create service types
   - Configure bays
   - Set up insurance companies
   - Configure pricing matrix

## Business Logic Flow

### Service Booking Flow
1. Customer books service → Job Card created
2. Technician assigned → Activity scheduled
3. Scheduler updates → Bay allocated
4. Sales Order generated → Customer notified
5. Service completion → Invoice generated
6. Insurance split applied → Payment processed

### Scheduler Dynamics
1. User selects date/time and bay
2. System checks availability
3. Activities added to scheduler
4. Sales Order automatically updated
5. Estimated delivery date calculated
6. Progress tracked in real-time
7. User can reschedule anytime
8. Changes propagate to Sales Order

### Insurance Processing
1. Claim created with service details
2. Split calculation applied (40% customer / 60% insurance)
3. Separate invoices generated
4. Insurance party billed separately
5. Customer charged for their portion

## Database Schema

### Key Relationships
- Car ← → Service (1:M)
- Service ← → JobCard (1:M)
- JobCard ← → SalesOrder (1:1)
- Scheduler ← → SchedulerLine (1:M)
- SchedulerLine ← → Bay (M:1)
- SchedulerLine ← → Service (M:1)
- Service ← → Insurance (M:1)
- InsuranceClaim ← → Service (M:1)

## API Integration Points

### External Systems Integration
- **Dynamics 365 Sales**: Customer data sync
- **Payment Gateway**: Payment processing
- **Email Service**: Notifications
- **SMS Service**: Customer updates
- **Power BI**: Analytics

## Security & Permissions

### Role-Based Access
- **Service Manager**: Full access to all modules
- **Technician**: Access to job cards and scheduler
- **Customer**: Portal access only
- **Insurance Admin**: Insurance claims access
- **Accountant**: Financial data access

## Future Enhancements

- Mobile app integration
- SMS/Email notifications
- Payment gateway integration
- Advanced reporting dashboards
- Customer mobile tracking
- Inventory management integration
- Parts management
- Warranty tracking

## Version History

- **v1.0.0** - Initial release with core features

## License

Proprietary - BMW Dealer Management System

## Support

For support and inquiries, contact: development@bmwdealerservices.com

## Contributors

- Harpreet MBS (theharpreetmbs)

---

**Last Updated**: 2026-07-18
