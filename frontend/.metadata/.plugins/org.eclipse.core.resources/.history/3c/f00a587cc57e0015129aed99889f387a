package librarymanagement;

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JTextArea;

public class ProfileDisplay extends JFrame {

	private JPanel contentPane;
    private JLabel oname;
	/**
	 * Launch the application.
	 */
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					ProfileDisplay frame = new ProfileDisplay();
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
	public ProfileDisplay() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel name = new JLabel("Name");
		name.setBounds(35, 16, 69, 20);
		contentPane.add(name);
		
		
		
		
	}
	
	public void displayData(List<Profile> Profile)
	{
		
		oname = new JLabel("");
		oname.setBounds(119, 16, 69, 20);
		contentPane.add(oname);
		this.oname.setText(Profile.get(0).toString());	
		
	}
}
