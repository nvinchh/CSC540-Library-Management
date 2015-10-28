package librarymanagement;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.JPasswordField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class StudentLogin extends JFrame {

	private JPanel contentPane;
	private JTextField studentid;
	private JPasswordField passwordField;
	private LoginDAO student;
    public  static String studentpointer; 
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					StudentLogin frame = new StudentLogin();
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
	public StudentLogin() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		JLabel lblNewLabel = new JLabel("Student ID");
		lblNewLabel.setBounds(65, 85, 84, 20);
		contentPane.add(lblNewLabel);

		JLabel lblNewLabel_1 = new JLabel("Password");
		lblNewLabel_1.setBounds(65, 137, 77, 20);
		contentPane.add(lblNewLabel_1);

		studentid = new JTextField();
		studentid.setBounds(164, 82, 146, 26);
		contentPane.add(studentid);
		studentid.setColumns(10);

		passwordField = new JPasswordField();
		passwordField.setBounds(164, 134, 146, 26);
		contentPane.add(passwordField);

		JButton btnSubmit = new JButton("Submit");
		btnSubmit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				try {
					LoginDAO conn = new LoginDAO();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String i = studentid.getText();
				String pswd = passwordField.getText();
				try {
					student = new LoginDAO();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				int result = student.checkStudent(i, pswd);

				if (result == 1) {
                  studentpointer=i;
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
		btnSubmit.setBounds(65, 188, 115, 29);
		contentPane.add(btnSubmit);
	}

}
