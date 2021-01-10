<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Eksetasi apo Giatro</title>
<style>
 input[type=text] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
 }
</style>
</head>
<%
  String name = request.getParameter("name");
  out.println("O asthenis " +name+ " eisilthe sto TEP.");
%>
<body>
 <br><br><label for="diagnosis"><b>Diagnosis</b></label>
  <input type="text" placeholder="Enter Diagnosis" name="diagnosis" id="diagnosis" required>

</body>
</html>

<% 
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