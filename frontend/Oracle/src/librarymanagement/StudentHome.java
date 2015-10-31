package librarymanagement;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.awt.event.ActionEvent;

public class StudentHome extends JFrame {
	public LoginDAO profile;
	public ProfileDisplay p;
	private JPanel contentPane;
    
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					StudentHome frame = new StudentHome();
					frame.setVisible(true);
					frame.setResizable(false);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public StudentHome() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(500, 500, 700, 550);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton btnProfile = new JButton("Profile");
		btnProfile.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0){
				try {
					/*StudentLogin pointer = new StudentLogin();
					String s_id= pointer.studentpointer;
					profile = new LoginDAO();
					List<Profile> profileOutput= profile.getProfile(s_id);
					System.out.println(profileOutput.size());
					System.out.println(profileOutput.get(0));*/
					setVisible(false);
					ProfileDisplay p=new ProfileDisplay();
					p.setVisible(true);
					//p.displayData(profileOutput);
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
			}
		});
		btnProfile.setBounds(77, 82, 181, 64);
		contentPane.add(btnProfile);
		
		JButton btnResources = new JButton("Resources");
		btnResources.setBounds(77, 181, 181, 64);
		contentPane.add(btnResources);
		
		JButton btnCheckedoutresources = new JButton("<html>Checked-Out-Resources</html>");
		btnCheckedoutresources.setBounds(384, 82, 201, 64);
		contentPane.add(btnCheckedoutresources);
		
		JButton btnResourcerequest = new JButton("<html>Resource-Request</html>");
		btnResourcerequest.setBounds(77, 282, 181, 64);
		contentPane.add(btnResourcerequest);
		
		JButton btnNotifications = new JButton("Notifications");
		btnNotifications.setBounds(384, 282, 201, 64);
		contentPane.add(btnNotifications);
		
		JButton btnDueBalance = new JButton("Due Balance");
		btnDueBalance.setBounds(384, 181, 201, 64);
		contentPane.add(btnDueBalance);
		
		JButton btnNewButton = new JButton("logout");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				StudentLogin s =new StudentLogin();
				setVisible(false);
				s.setVisible(true);
			}
		});
		btnNewButton.setBounds(531, 442, 119, 36);
		contentPane.add(btnNewButton);
	}
}
