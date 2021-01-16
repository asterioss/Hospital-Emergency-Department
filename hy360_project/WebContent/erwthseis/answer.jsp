<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer</title>
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
<form action="questions.jsp">

<%
String url = new String("jdbc:mysql://localhost");
String databaseName = new String("test");
int port = 3306;
String username = new String("root");
String password = new String("");
Connection con = null;
PreparedStatement stmt = null;
PreparedStatement temp = null;
Statement myStmt = null;
ResultSet rs = null;
ResultSet myrs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	String question = (String)request.getParameter("questions"); 
	//System.out.println(question);
	if(question.equals("katastasi_episkepsewn")) {
		myStmt = con.createStatement();
		
		myrs = myStmt.executeQuery("select * from dedomena_asthenwn");
		
		out.println("Oi shmerines episkepseis:");
	    out.println("<br>");
	    out.println("<br>");
		while (myrs.next()) {
			out.println("O asthenis " +myrs.getString("onomatepwnumo")+ " episkeftike to TEP me symptomata: " + myrs.getString("symptoms"));
		    out.println("<br>");
		}
		myrs.close();
		myStmt.close();
	}
	
	
	if(question.equals("covid_report")) {
		//System.out.println("ekei");
		
		stmt = con.prepareStatement("select * from eksetazomenoi_astheneis where diagnosis = ?");
		stmt.setString(1, "covid-19");
		
		rs = stmt.executeQuery();
		
		out.println("Oi astheneis pou exoun covid-19:");
	    out.println("<br>");
	    out.println("<br>");
		while (rs.next()) {
			temp = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
			temp.setString(1, rs.getString("onomatepwnumo"));
			
			myrs = temp.executeQuery();
			
			String nosima = "";
			if(myrs.next()) {
			  nosima = myrs.getString("xronia_nosimata");
			}
			temp.close();
			myrs.close();
			
			out.println("O asthenis " +rs.getString("onomatepwnumo")+ " diagnwstike me covid-19 ");
			if(nosima.equals("")) {
				out.println(" kai den exei xronia nosimata"); 
			}
			else {
				out.println(" kai exei xronia nosimata: " + nosima); 
			}
			out.println("<br>");
			
		}
		stmt.close();
		rs.close();
	}
	
}
catch(Exception e) {
	System.out.println(e);
} finally {
	//rs.close();
	//stmt.close();
	con.close();
}
%>

<button type="submit" class="btn">Go back</button>

</form>
</body>
</html>