<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Epaneksetasi Asthenous</title>
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
<form action="oloklirwsh_nosileias.jsp" method="post">
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
	
	String name = request.getParameter("name");
	//System.out.println("Name: "+name);
	stmt = con.prepareStatement("select * from eksetasi_patient where onomatepwnumo = ?");
	stmt.setString(1, name);
	
    rs = stmt.executeQuery();
	
	if(rs.next()) {
	   out.println("O asthenis " +name+ " diagnosthike me: " + rs.getString("diagnosis"));
	   if(rs.getString("farmakeutikh_agwgh")!="") {
	      out.println(" kai tou xorigithike: " + rs.getString("farmakeutikh_agwgh"));
	   }
	}
	else {
		System.out.println("Something gone wrong.");
	}
	rs.close();

%>
  <br><br><label for="nosileia"><b>Nosileia</b></label><br>
  <textarea id="nosileia" name="nosileia" rows="5" cols="100"></textarea>
  
  <input type="hidden" name="patient_name" value=<%=name%>>
  
  <button type="submit" class="hometbtn">Oloklirwsh noshleias</button>

</form>
</body>
</html>

<%
	
}
catch(Exception e) {
	System.out.println(e);
} finally {
	/*rs.close();
	stmt.close();
	con.close();*/
}
%>