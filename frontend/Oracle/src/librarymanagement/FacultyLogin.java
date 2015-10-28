package librarymanagement;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JPasswordField;

public class FacultyLogin extends JFrame {

	private JPanel contentPane;
	private JTextField facultyid;
	private LoginDAO faculty;
	private JPasswordField password;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					FacultyLogin frame = new FacultyLogin();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public FacultyLogin() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblFacultyid = new JLabel("Faculty_id");
		lblFacultyid.setBounds(67, 81, 85, 27);
		contentPane.add(lblFacultyid);
		
		JLabel lblPassword = new JLabel("Password");
		lblPassword.setBounds(67, 124, 69, 20);
		contentPane.add(lblPassword);
		
		facultyid = new JTextField();
		facultyid.setBounds(162, 81, 146, 26);
		contentPane.add(facultyid);
		facultyid.setColumns(10);
		
		
		password = new JPasswordField();
		password.setBounds(162, 121, 146, 26);
		contentPane.add(password);
		
		JButton btnSubmit = new JButton("Submit");
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				
				try {
					LoginDAO conn = new LoginDAO();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String i = facultyid.getText();
				String pswd = password.getText();
				try {
					faculty = new LoginDAO();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				int result = faculty.checkFaculty(i,pswd);

				if (result == 1) {
                  setVisible(false);
                  StudentHome student=new StudentHome();
                  student.setVisible(true);
                  }
				
				else
				{
					JOptionPane.showMessageDialog(null,"Incorrect user-id/password");
				}
			}
		});
		btnSubmit.setBounds(67, 174, 115, 29);
		contentPane.add(btnSubmit);
	
	}
}