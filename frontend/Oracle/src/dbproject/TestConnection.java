package dbproject;
import java.sql.*;
import java.io.*;
public class TestConnection {

	public static void connect()
	// TODO Auto-generated method stub
	{	
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}

		catch(Exception e)
		{
			System.out.println(e);
		}
	}

	public static void insertValues(int dept_code,String name)
	{
		connect();	
		Connection conn;
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sys as SYSDBA","oracle");
			PreparedStatement st=(PreparedStatement)conn.prepareStatement("insert into test_departments(dept_code,dept_name)VALUES(?,?)");
			st.setInt(1,dept_code);
			st.setString(2,name);
			st.executeUpdate();
			displayValues();
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void insertprocValues(int dept_code,String name)
	{
		connect();	
		Connection conn;
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sys as SYSDBA","oracle");
		     CallableStatement mystmnt=null;
		     mystmnt=conn.prepareCall("{call insertdepartments(?,?)}");
		     
		     mystmnt.setInt(1, dept_code);
		     mystmnt.setString(2, name);
		     
		     mystmnt.execute();
		     
		     displayValues();
		     
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void displayValues()
	{
		connect();	
		Connection conn1;	
		try{
			conn1 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","sys as SYSDBA","oracle");
			String query="select * from departments where dept_code=5";
			Statement st=conn1.createStatement();
			ResultSet rst=st.executeQuery(query);
			while(rst.next())
				System.out.println(rst.getInt(1)+" "+rst.getString(2));
			conn1.close();
		}
		catch(SQLException e){
			System.out.println(e);	
		}
	}

	public static void main(String args[])throws IOException
	{
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader stdin= new BufferedReader(isr);
		System.out.println("Enter the id");
		int x=Integer.parseInt(stdin.readLine());
		System.out.println("Enter the department name");
		String department=stdin.readLine();
		insertprocValues(x,department);
	}
}


