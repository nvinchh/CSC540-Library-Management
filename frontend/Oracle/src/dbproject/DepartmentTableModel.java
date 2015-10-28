package dbproject;

import javax.swing.table.AbstractTableModel;
import java.util.*;

public class DepartmentTableModel extends AbstractTableModel {

	private static final int dept_code_col = 0;
	private static final int dept_name_col = 1;

	private String[] columnNames = { "dept_code", "dept_name" };

	private List<Department> departments;

	public DepartmentTableModel(List<Department> theDepartments) {
		departments = theDepartments;
	}

	// overrode the method
	public int getColumnCount() {
		return columnNames.length;
	}

	// override the method

	public int getRowCount() {
		return departments.size();
	}

	public String getColumnName(int col) {
		return columnNames[col];
	}

	public Object getValueAt(int row,int col)
	{
		Department tempDepartment=departments.get(row);
		
		switch (col){
			case dept_code_col:
			return tempDepartment.getDept_code();
			case dept_name_col:
			return tempDepartment.getDept_name();	
			default:
			return tempDepartment.getDept_name();
			
		}
	}
	
	public Class getColumnClass(int c){
		return getValueAt(0, c).getClass();
	}
}
