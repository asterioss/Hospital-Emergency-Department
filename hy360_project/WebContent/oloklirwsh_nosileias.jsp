<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Oloklirwsh nosileias</title>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
 }
</style>
</head>
<body>
<form action="home_page.jsp" method="post">
  <h2 style="text-align:center;">H nosileia prostethike me epituxia</h2>
  
  <button type="submit" class="hometbtn">Go to Home Page</button>
  
</form>
</body>
</html>

<%
String nosileia = request.getParameter("nosileia");
String name = (String)request.getParameter("patient_name");
System.out.println(name+", "+nosileia);

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
	
	//update ton pinaka kai vazoume thn nosileia
	/*stmt = con.prepareStatement("update eksetasi_patient set anafora = ? where name = ?");
	stmt.setString(1, anafora);
	stmt.setString(2, name);
	
	stmt.executeUpdate();*/
		
}
catch(Exception e) {
	System.out.println(e);
} finally {
	//stmt.close();
	con.close();
}
%>