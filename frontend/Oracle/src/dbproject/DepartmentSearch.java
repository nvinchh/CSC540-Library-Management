package dbproject;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.FlowLayout;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import java.util.List;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.ActionEvent;
import dbproject.Department;
import dbproject.StudentDAO;

public class DepartmentSearch extends JFrame {

	private JPanel contentPane;
	private JTextField departmentNametextField;
	private JTable table;
	private StudentDAO studentDAO;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					DepartmentSearch frame = new DepartmentSearch();
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
	public DepartmentSearch() {
		try {
			studentDAO = new StudentDAO();

		} catch (Exception exc) {
			JOptionPane.showMessageDialog(this, "Error: " + exc, "Error", JOptionPane.ERROR_MESSAGE);
		}
		setTitle("Department Search");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(300, 300, 750, 500);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);

		JPanel panel = new JPanel();
		FlowLayout flowLayout = (FlowLayout) panel.getLayout();
		flowLayout.setAlignment(FlowLayout.LEFT);
		contentPane.add(panel, BorderLayout.NORTH);

		JLabel lblSearchDepartments = new JLabel("Search Departments:");
		panel.add(lblSearchDepartments);

		departmentNametextField = new JTextField();
		panel.add(departmentNametextField);
		departmentNametextField.setColumns(8);

		JButton btnSearch = new JButton("Search");
		btnSearch.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				//get value from text field
				//if not empty use search method
				//if empty use get all method
				try {
					String departmentName = departmentNametextField.getText();

					List<Department> deptName = null;

					if (departmentName != null && departmentName.trim().length() > 0) {
						deptName=studentDAO.searchallDepartments(departmentName);
					} else {
						deptName=studentDAO.getAllDepartments();
					}
					/*for (Department dept : deptName) {
						System.out.println(dept + " ");
					}
					*/
					DepartmentTableModel dept=new DepartmentTableModel(deptName);
					table.setModel(dept);
				} catch (Exception exc) {
					JOptionPane.showMessageDialog(DepartmentSearch.this, "Error: " + exc, "Error", JOptionPane.ERROR_MESSAGE);
				}

			}
		});
		panel.add(btnSearch);
				
				
		
				JScrollPane scrollPane = new JScrollPane();
				panel.add(scrollPane);
				
						table = new JTable();
						scrollPane.setViewportView(table);
	}

}
