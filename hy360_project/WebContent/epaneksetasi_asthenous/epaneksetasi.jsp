<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Epaneksetasi Asthenous</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
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
	stmt = con.prepareStatement("select * from eksetazomenoi_astheneis where onomatepwnumo = ?");
	stmt.setString(1, name);
	
    rs = stmt.executeQuery();
	
	if(rs.next()) {
	   out.println("O asthenis " +name+ " diagnosthike me: " + rs.getString("diagnosis"));
	   //System.out.println(rs.getString("farmakeutikh_agwgh"));
	   if(rs.getString("farmakeutikh_agwgh").equals("")) {
		  out.println(" kai den tou xorigithike tipota."); 
	   }
	   else {
		  out.println(" kai tou xorigithike: " + rs.getString("farmakeutikh_agwgh")+"."); 
	   }
	   out.println("<br>");
	   out.println("<br>");
	   
	   if(rs.getString("farmakeutikh_agwgh").equals("")) out.println("Den eixe anafora apo to nosileutiko.");
	   else out.println("H anafora apo to nosileutiko htan: " +rs.getString("anafora"));
	}
	else {
		System.out.println("Something gone wrong.");
	}
	rs.close();

%>
  <br><br><label for="nosileia"><b>Nosileia</b></label><br>
  <select name="nosileia" id="nosileia">
    <option value="nai">Nai</option>
    <option value="oxi">Oxi</option>
  </select>
  
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
	//rs.close();
	stmt.close();
	con.close();
}
%>