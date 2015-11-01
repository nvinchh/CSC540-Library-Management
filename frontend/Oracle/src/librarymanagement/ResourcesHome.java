package librarymanagement;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class ResourcesHome extends JFrame {

	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					ResourcesHome frame = new ResourcesHome();
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
	public ResourcesHome() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(500, 500, 700, 550);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton books = new JButton("Books");
		books.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		books.setBounds(126, 78, 115, 41);
		contentPane.add(books);
		
		JButton journals = new JButton("Journals");
		journals.setBounds(126, 175, 115, 41);
		contentPane.add(journals);
		
		JButton ConfProceedings = new JButton("confproceedings");
		ConfProceedings.setBounds(126, 254, 115, 49);
		contentPane.add(ConfProceedings);
		
		JButton camera = new JButton("Camera");
		camera.setBounds(126, 341, 115, 41);
		contentPane.add(camera);
		
		JButton Rooms = new JButton("Rooms");
		Rooms.setBounds(351, 341, 115, 41);
		contentPane.add(Rooms);
		
		JButton logout = new JButton("logout");
		logout.setBounds(512, 434, 115, 29);
		contentPane.add(logout);
		
		JButton ebooks = new JButton("Ebooks");
		ebooks.setBounds(351, 78, 115, 41);
		contentPane.add(ebooks);
		
		JButton ejournal = new JButton("Ejournal");
		ejournal.setBounds(351, 175, 115, 41);
		contentPane.add(ejournal);
		
		JButton econfproceedings = new JButton("EConfProceedings");
		econfproceedings.setBounds(351, 254, 143, 41);
		contentPane.add(econfproceedings);
	}
}
