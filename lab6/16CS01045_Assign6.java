import java.util.*;
import java.sql.*;
import java.io.*;

public class Assignment_6
{
	public static Scanner scn = new Scanner(System.in);

	public static void main(String[] args) throws SQLException, IOException
	{
		System.out.println("----------------------Oracle JDBC Connection Testing-------------------------");

		try 
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println("Where is your Oracle JDBC Driver?");
			e.printStackTrace();
			return;
		}

		System.out.println("Oracle JDBC Driver Registered!");

		Connection connection = null;

		try
		{
			connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "CS01045", "bbsian");
		} 
		catch (SQLException e) 
		{
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
		}

		if (connection != null) 
			System.out.println("You made it, take control your database now!");
		else 
			System.out.println("Failed to make connection!");
		
		Q1(connection);
		Q2(connection);
		Q3(connection);
		Q4(connection);
		Q5(connection);
		System.out.println("-----------------------------------END---------------------------------------");
		
        connection.close();
	}
	
	static void Q1(Connection connection) throws SQLException
	{
		System.out.println("-------------------------------Question-(1)----------------------------------");
		
		String SQL = "Select Job_id, Job_title from JOBS where Min_salary < (select Salary from Employees where Employee_id = ?)";
		PreparedStatement pstmt = connection.prepareStatement(SQL);
		
		System.out.print("Enter Employee-id: ");
		int temp_id = scn.nextInt();
		
		pstmt.setInt(1, temp_id); 
		
		ResultSet r1 = pstmt.executeQuery();
		
		System.out.println();
		if(!r1.isBeforeFirst())
        	System.out.println("No Data");
		
        while(r1.next() != false)
        {
        	System.out.println(r1.getString("Job_id")+"\n\t"+r1.getString("Job_title"));
        }
        			
        r1.close();
        pstmt.close();
	}
	
	static void Q2(Connection connection) throws SQLException
	{
		System.out.println("-------------------------------Question-(2)----------------------------------");
		
		String SQL = "{call Q2(?, ?, ?)}";
		CallableStatement cstmt = connection.prepareCall(SQL);
				
		System.out.print("Enter Employee-id: ");
		int temp_id = scn.nextInt();
		
		cstmt.setInt(1, temp_id);
		cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
		
		cstmt.execute();
		
		System.out.println();
		
		if(cstmt.getString(2) != null || cstmt.getString(3) != null)
			System.out.println(cstmt.getString(2)+"\t"+cstmt.getString(3));
		else
			System.out.println("No Data");
		
		cstmt.close();
	}
	
	static void Q3(Connection connection) throws SQLException
	{
		System.out.println("-------------------------------Question-(3)----------------------------------");
		
		String SQL = "select e.First_name||' '||e.Last_name Emp_name, j.Job_title from Employees e, Jobs j where e.Job_id = j.Job_id and to_date(e.Hire_date, 'DD-MM-YY') > to_date(?, 'DD-MM-YY') and exists(select * from Employees e1 where e1.Employee_id = e.Manager_id and e1.Department_id = ?)";                 
		PreparedStatement pstmt = connection.prepareStatement(SQL);
		
	    System.out.print("Enter date('DD-MM-YY'): ");
	    String temp_date = scn.next();
	    
	    System.out.print("Enter Department-id: ");
	    int temp_id = scn.nextInt();
	    
	    pstmt.setString(1, temp_date);
	    pstmt.setInt(2, temp_id);
 	   
		ResultSet r3 = pstmt.executeQuery();
		
		System.out.println();
		if(!r3.isBeforeFirst())
			System.out.println("No Data");
		
		while(r3.next())
		{
			System.out.println(r3.getString("Emp_name")+"\n\t\t"+r3.getString("Job_title"));
		}
		
		r3.close();
		pstmt.close();
	}
	
	static void Q4(Connection connection) throws SQLException
	{
		System.out.println("-------------------------------Question-(4)----------------------------------");
		
		String SQL = "update Employees set Salary = Salary*1.05, Job_id = ? where Employee_id = ?";
		PreparedStatement pstmt = connection.prepareStatement(SQL);
	
		System.out.print("Enter Employee_id: ");
		int temp_emp_id = scn.nextInt();
		
		System.out.print("Enter Job_id: ");
		String temp_job_id = scn.next();
		
		pstmt.setString(1, temp_job_id); 
		pstmt.setInt(2, temp_emp_id);
		
		int count = pstmt.executeUpdate();
		System.out.println("\nNo of rows affected: "+count);
	}
	
	static void Q5(Connection connection) throws SQLException, IOException
	{
		System.out.println("-------------------------------Question-(5)----------------------------------");
		
		String SQL = "select d.department_id, department_name, sum(salary) from employees e, departments d where e.department_id = d.department_id group by d.department_id, department_name having sum(salary) > 100000";
		PreparedStatement pstmt = connection.prepareStatement(SQL);
		
		ResultSet r5 = pstmt.executeQuery();
		
		System.out.println();
		if(!r5.isBeforeFirst())
			System.out.println("No Data");
		
		try(FileWriter fw = new FileWriter("Q5_out.txt"))
        {
            fw.write("Dept_id\tDept_name\tTotal_salary\n");
            while(r5.next())
            {
                fw.write(r5.getInt(1)+"\t\t"+r5.getString(2)+"\t"+r5.getInt(3)+"\n");
            }
            fw.close();
        }
		System.out.println("\nThe output has been written to Q5_out.txt");
		r5.close();
		pstmt.close();
	}
}














