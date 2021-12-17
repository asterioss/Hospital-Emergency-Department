<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Oloklirwsh anaforas</title>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
</style>
</head>
<body>
<form action="../home_page.jsp" method="post">
  <h2 style="text-align:center;">H anafora prostethike me epituxia</h2>
  
  <button type="submit" class="hometbtn">Go to Home Page</button>
  
</form>
</body>
</html>

<%
String anafora = request.getParameter("anafora");
String name = (String)request.getParameter("patient_name");
//System.out.println(name);

String url = new String("jdbc:mysql://localhost");
String databaseName = new String("test");
int port = 3306;
String username = new String("root");
String password = new String("");
Connection con = null;
PreparedStatement stmt = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	//update ton pinaka kai vazoume thn anafora
	stmt = con.prepareStatement("update eksetazomenoi_astheneis set anafora = ? where name = ?");
	stmt.setString(1, anafora);
	stmt.setString(2, name);
	
	stmt.executeUpdate();
	stmt.close();
	
	
}
catch(Exception e) {
	System.out.println(e);
} finally {
	stmt.close();
	con.close();
}
%>