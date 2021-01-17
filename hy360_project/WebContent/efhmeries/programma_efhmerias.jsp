<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Efhmeries</title>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
</style>
</head>
<body>
<form action="../home_page.jsp">

<%
String url = new String("jdbc:mysql://localhost");
String databaseName = new String("test");
int port = 3306;
String username = new String("root");
String password = new String("");
Connection con = null;
Statement temp = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	temp = con.createStatement();
	
	rs = temp.executeQuery("select * from dedomena_prosopikou");
	
	int i=0;
	out.println("Trexousa efhmeria");
	out.println("<br>");
	out.println("Diathesimo proswpiko:");
	out.println("<br>");
	out.println("<br>");
	while (rs.next()) {
		i++;
		out.println(rs.getString("onomatepwnumo"));
		out.println("<br>");
		if(i==9) {
		   out.println("<br>");
		   out.println("<br>");
		   out.println("Epomenh efhmeria");
		   out.println("<br>");
		   out.println("Diathesimo proswpiko:");
		   out.println("<br>");
		   out.println("<br>");
		}
	}
	temp.close();
	rs.close();
	
}
catch(Exception e) {
	System.out.println(e);
} finally {
	rs.close();
	temp.close();
	con.close();
}
%>

<br><button type="submit" class="addbtn">Go to Home Page</button>

</form>
</body>
</html>