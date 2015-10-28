package librarymanagement;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class LoginDAO {
	private Connection conn;
    private int countStudent;
    private int countFaculty;
	public LoginDAO() throws Exception {
		System.out.println(new java.io.File("").getAbsolutePath());

		// load database details
		Properties prop = new Properties();
		prop.load(new FileInputStream("C:/Users/Vaibhav/workspace/Oracle/Sql/dbinfo.properties"));

		String dburl = prop.getProperty("dburl");
		String user = prop.getProperty("user");
		String password = prop.getProperty("password");

		conn = DriverManager.getConnection(dburl, user, password);

		System.out.println("Connection Established");
	}
	
	public int checkStudent(String studentid,String password)
	{
		try
		{
		PreparedStatement pst=conn.prepareStatement("select * from students where s_id=? and pswd=?");
		pst.setString(1, studentid);
		pst.setString(2, password);
		
		ResultSet rst=pst.executeQuery();
		countStudent=0;
		while(rst.next())
		{
			countStudent=countStudent+1;
		}
		conn.close();
		}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return countStudent;
	}
	
	public int checkFaculty(String facultyid,String password)
	{
		try
		{
        PreparedStatement pst=conn.prepareStatement("select * from faculty where f_id=? and pswd=?");
		pst.setString(1, facultyid);
		pst.setString(2, password);
		
		ResultSet rst=pst.executeQuery();
		
		countFaculty=0;
		while(rst.next())
		{
			countFaculty=countFaculty+1;
		}
		conn.close();
		}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return countFaculty;
	}
	
	public static void main(String args[]) throws Exception
	{
		LoginDAO newtest=new LoginDAO();
		int r =newtest.checkFaculty("f1","wwhite");
		System.out.println(r);
		
		
	}
}

