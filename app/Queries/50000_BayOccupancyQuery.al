query 50000 "Bay Occupancy Query"
{
    QueryType = Normal;
    OrderBy = ascending("Current_Car_No");
    
    elements
    {
        dataitem(Bay; "Bay")
        {
            column(No; "No.")
            {
            }
            column(Description; "Description")
            {
            }
            column(Bay_Type; "Bay Type")
            {
            }
            column(Status; "Status")
            {
            }
            column(Current_Car_No; "Current Car No.")
            {
            }
            column(Current_Activity; "Current Activity")
            {
            }
            column(Activity_Start_Time; "Activity Start Time")
            {
            }
            column(Activity_End_Time; "Activity End Time")
            {
            }
            column(Utilization_Rate; "Utilization Rate")
            {
            }
        }
    }
}
