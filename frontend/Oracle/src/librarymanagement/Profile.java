package librarymanagement;

public class Profile {
	
	private String first_name;
	private String last_name;
	private String sex; 
	private String nationality;
	private int main_phone;
	private String city;           
	private String street;
	private String zipcode;
	private String degree_program ;
	private String classification ;
	private String s_category ;
	private double  s_credit;
	
	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	
	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public int getMain_phone() {
		return main_phone;
	}

	public void setMain_phone(int main_phone) {
		this.main_phone = main_phone;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getDegree_program() {
		return degree_program;
	}

	public void setDegree_program(String degree_program) {
		this.degree_program = degree_program;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getS_category() {
		return s_category;
	}

	public void setS_category(String s_category) {
		this.s_category = s_category;
	}

	public Double getS_credit() {
		return s_credit;
	}

	public void setS_credit(double s_credit) {
		this.s_credit = s_credit;
	}
	
	


	public Profile(String first_name,String last_name,String sex,String nationality,
	int main_phone,String city,String street,String zipcode,String degree_program,
	String classification,
	String s_category,
	double  s_credit) {
		super();
		this.first_name = first_name;
		this.last_name = last_name;
		this.sex=sex;
		this.nationality=nationality;
		this.main_phone=main_phone;
		this.city=city;
		this.street=street;
		this.zipcode=zipcode;
		this.degree_program=degree_program;
		this.classification=classification;
		this.s_category=s_category;
		this.s_credit=s_credit;
	}
 public String toString()
 {
			return String.format(this.first_name+this.last_name+this.sex+this.nationality+this.main_phone+this.city+
					this.street+this.zipcode+this.degree_program+this.degree_program+
					this.classification+this.s_category+this.s_credit);
 }
}
