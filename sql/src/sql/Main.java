package sql;
import java.sql.*;

public class Main {
	public static void main(String[] args) {
		String url = new String("jdbc:mysql://localhost");
		String databaseName = new String("test");
		int port = 3306;
		String username = new String("root");
		String password = new String("");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(
			url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
			//System.out.println("Connected");
			
			Statement stmt = con.createStatement();
			
			String insertEmployee = new String("insert into employee "
					+ " (first_name, last_name, email, mobile)"
			        + " values ('george', 'papadopoulos', 'ekei@gmail.com', 697827029)");
			stmt.executeUpdate(insertEmployee);
			System.out.println("Insert Employee Completed");
			
			/*String deleteEmployee = new String("delete from employee where last_name='papadopoulos'");
			
			stmt.executeUpdate(deleteEmployee);
			System.out.println("Delete Employee Completed");*/

		}
		catch(Exception E) {
			System.out.println(E);
		}
		
	}

}
