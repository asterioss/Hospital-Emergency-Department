<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Eksetasi Nosileutikou</title>
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
<form action="oloklirwsh_anaforas.jsp" method="post">
<%String name = (String)request.getParameter("patient_name");%>

 <label for="anafora"><b>Anafora apo nosileutes</b></label><br>
 <textarea id="anafora" name="anafora" rows="5" cols="100">
 </textarea>
 
 <input type="hidden" name="patient_name" value=<%=name%>>

 <button type="submit" class="btn">Epivevaiwsh anaforas</button>

</form>
</body>
</html>

<%
String diagnosi = (String)request.getParameter("diagnosis");
String farmako = (String)request.getParameter("farmaka");
//out.println("Diagnosi: "+diagnosi+", Farmako: "+farmako+", name:"+name);

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
	
	//kanoume update ton pinaka kai vazoume diagnosi kai farmaka
	stmt = con.prepareStatement("update eksetasi_patient set diagnosis = ?, farmakeutikh_agwgh = ? where name = ?");
	stmt.setString(1, diagnosi);
	if(farmako!=null) stmt.setString(2, farmako);
	stmt.setString(3, name);
	
	stmt.executeUpdate();
		
}
catch(Exception e) {
	System.out.println(e);
} finally {
	stmt.close();
	con.close();
}

%>
