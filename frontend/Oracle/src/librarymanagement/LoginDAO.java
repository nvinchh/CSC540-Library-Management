package librarymanagement;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import dbproject.Department;

public class LoginDAO {
	private Connection conn;
    private int countStudent;
    private int countFaculty;
    private List<Profile> list=new ArrayList();
    public LoginDAO() throws Exception {
		System.out.println(new java.io.File("").getAbsolutePath());

		// load database details
		Properties prop = new Properties();
		prop.load(new FileInputStream("C:/Users/admin/Documents/GitHub/CSC540_LibraryManagment/frontend/Oracle/Sql/dbinfo.properties"));
	
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
	
	public List<Profile> getProfile(String s_id) throws Exception{
		try {
			
			PreparedStatement pst=conn.prepareStatement("select * from students where s_id=?");
			pst.setString(1, s_id);
			ResultSet rst=pst.executeQuery();
			while(rst.next())
			{
				Profile tempprofile=convertRowToProfile(rst);
				list.add(tempprofile);
				}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	private Profile convertRowToProfile(ResultSet rst) throws SQLException {

		String first_name = rst.getString(2);
		String last_name= rst.getString(3);
		String sex=rst.getString(4);
		String nationality=rst.getString(6);
		int main_phone=rst.getInt(7);
		String city=rst.getString(9);
		String street=rst.getString(10);
		String zipcode=rst.getString(11);
		String degree_program=rst.getString(12);
		String classification=rst.getString(13);
		String s_category=rst.getString(14);
		double s_credit=rst.getDouble(15);		
		Profile tempProfile = new Profile(first_name,last_name,sex,nationality,main_phone,city,street,
				zipcode,degree_program,classification,s_category,s_credit);
		return tempProfile;
	}
    
	
	public static void main(String args[]) throws Exception
	{
		LoginDAO newtest=new LoginDAO();
		List r =newtest.getProfile("S1");
		System.out.println(r.size());
	}
}

