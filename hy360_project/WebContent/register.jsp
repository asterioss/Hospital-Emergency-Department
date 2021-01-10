<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% String name = request.getParameter("username");
 String pass = request.getParameter("psw");
 String mail = request.getParameter("email");
 
 String url = new String("jdbc:mysql://localhost");
 String databaseName = new String("test");
 int port = 3306;
 String username = new String("root");
 String password = new String("");
 Connection con = null;
 PreparedStatement create = null;
 PreparedStatement stmt = null;

 try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	// to table me tous users 
	//temp.executeUpdate("drop table if exists users");
	create = con.prepareStatement("CREATE TABLE IF NOT EXISTS users " +
		               "(email VARCHAR(255) not NULL, " +
		               " username VARCHAR(255) not NULL," + 
		               " password VARCHAR(255) not NULL, " + 
		               " PRIMARY KEY ( email ))");
	create.executeUpdate();
	
	stmt = con.prepareStatement("insert into users(email,username,password)values(?,?,?)");
	stmt.setString(1, mail);
	stmt.setString(2, name);
	stmt.setString(3, pass);
	
	stmt.executeUpdate();
	//out.println("Registered Succesfully!");
	
	response.sendRedirect("home_page.jsp");
	
    }
    catch(Exception e) {
	   System.out.println(e);
    } finally {
       create.close();
	   stmt.close();
	   con.close();
    }

%>
