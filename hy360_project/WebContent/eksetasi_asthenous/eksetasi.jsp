<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Eksetasi apo Giatro</title>
</head>
<body>

</body>
</html>

<%
 String name = request.getParameter("name");
 out.println(name);
 
 String url = new String("jdbc:mysql://localhost");
 String databaseName = new String("test");
 int port = 3306;
 String username = new String("root");
 String password = new String("");
 Connection con = null;
 PreparedStatement stmt = null;
 ResultSet rs = null;

 try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	//stmt = con.prepareStatement("select * from users where username = ? AND password = ?");
	//stmt.setString(1, name);

	
	//response.sendRedirect("home_page.html");
	
 }
 catch(Exception e) {
	System.out.println(e);
 } finally {
	 //rs.close();
	 //stmt.close();
	 con.close();
 }

%>