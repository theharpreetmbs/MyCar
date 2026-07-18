query 50001 "Service Status Query"
{
    QueryType = Normal;
    OrderBy = ascending("Scheduled_Start_Date");
    
    elements
    {
        dataitem(Scheduler; "Scheduler")
        {
            column(No; "No.")
            {
            }
            column(Car_No; "Car No.")
            {
            }
            column(Status; "Status")
            {
            }
            column(Scheduled_Start_Date; "Scheduled Start Date")
            {
            }
            column(Expected_Delivery_Date; "Expected Delivery Date")
            {
            }
            column(Total_Estimated_Cost; "Total Estimated Cost")
            {
            }
            
            dataitem(SchedulerLine; "Scheduler Line")
            {
                DataItemLink = "Scheduler No." = Scheduler."No.";
                column(Activity_Sequence; "Activity Sequence")
                {
                }
                column(Service_Description; "Service Description")
                {
                }
                column(Activity_Status; "Activity Status")
                {
                }
                column(Progress; "Progress %")
                {
                }
            }
        }
    }
}
