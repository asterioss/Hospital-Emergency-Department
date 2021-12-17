<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Oloklirwsh nosileias</title>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
</style>
</head>
<body>
<form action="../home_page.jsp" method="post">
<%
String nosileia = (String)request.getParameter("nosileia");
String name = (String)request.getParameter("patient_name");
//System.out.println(name+", "+nosileia);
if(nosileia.equals("nai")) {
	out.println("O asthenis "+name+" tha nosileutei.");
	out.println("<br>");
}
else if(nosileia.equals("oxi")) {
	out.println("O asthenis "+name+" phgainei sto spiti tou.");
	out.println("<br>");
} 
%>

  <br><button type="submit" class="hometbtn">Go to Home Page</button>
  
</form>
</body>
</html>

<%
String url = new String("jdbc:mysql://localhost");
String databaseName = new String("test");
int port = 3306;
String username = new String("root");
String password = new String("");
Connection con = null;
//Statement temp = null;
PreparedStatement stmt = null;
PreparedStatement create = null;
PreparedStatement insert = null;
ResultSet myRs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	//an nosileia=nai, tote menei sto nosokomeio
			
	create = con.prepareStatement("CREATE TABLE IF NOT EXISTS nosileuomenoi_astheneis " +
         "(onomatepwnumo VARCHAR(255) not NULL, " +
         " amka VARCHAR(255) not NULL, " + 
         " diagnosis VARCHAR(255) not NULL, " + 
         " farmakeutikh_agwgh VARCHAR(255) not NULL, " + 
         " dieuthinsi VARCHAR(255) not NULL, " + 
         " asfalistikos_foreas VARCHAR(255) not NULL, " + 
         " xronia_nosimata VARCHAR(255) not NULL, " +
         " symptoms VARCHAR(255) not NULL, " +
         " PRIMARY KEY ( onomatepwnumo ))");
    create.executeUpdate();
    create.close();
			
	//an nosileia=oxi, tote ton diagrafoume apo tous astheneis pou perimenoun
	stmt = con.prepareStatement("select * from eksetazomenoi_astheneis where name = ?");
	stmt.setString(1, name);
	
	myRs = stmt.executeQuery();
	
	String fullname = "";
	String diagnosis = "";
	String farmaka = "";
	if (myRs.next()) {
		fullname = myRs.getString("onomatepwnumo");
		diagnosis = myRs.getString("diagnosis");
		farmaka = myRs.getString("farmakeutikh_agwgh");
	}
	myRs.close();
	stmt.close();
	
	stmt = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
	stmt.setString(1, fullname);
	
    myRs = stmt.executeQuery();
	
	String amka = "";
	String address = "";
	String asf_for = "";
	String nosimata = "";
	String symptom = "";
	if (myRs.next()) {
		amka = myRs.getString("amka");
		address = myRs.getString("dieuthinsi");
		asf_for = myRs.getString("asfalistikos_foreas");
		nosimata = myRs.getString("xronia_nosimata");
		symptom = myRs.getString("symptoms");
	}
	myRs.close();
	stmt.close();
	
	//an einai na nosileutei, ton kanoume insert sto table nosileuomenoi_astheneis
	if(nosileia.equals("nai")) {
		//System.out.println("ekei");
		insert = con.prepareStatement("insert into nosileuomenoi_astheneis(onomatepwnumo,amka,diagnosis,farmakeutikh_agwgh,dieuthinsi,asfalistikos_foreas,xronia_nosimata,symptoms)" +
		"values(?,?,?,?,?,?,?,?)");
		 insert.setString(1, fullname);
		 insert.setString(2, amka);
		 insert.setString(3, diagnosis);
		 insert.setString(4, farmaka);
		 insert.setString(5, address);
		 insert.setString(6, asf_for);
		 insert.setString(7, nosimata);
		 insert.setString(8, symptom);
		 //insert.setString(6, symptom);
		    	
		 insert.executeUpdate();
		 //out.println("O asthenis "+fullname+" prostethike me epituxia.");
		 //response.sendRedirect("add_patient.html");
		 insert.close();
	}
	
	//diagrafh astheni apo ton pinaka dedomena_asthenwn
	stmt = con.prepareStatement("delete from dedomena_asthenwn where onomatepwnumo = ?");
	stmt.setString(1, fullname);
	stmt.executeUpdate();
		
	//diagrafh astheni apo ton pinaka dedomena_asthenwn
	stmt = con.prepareStatement("delete from eksetazomenoi_astheneis where onomatepwnumo = ?");
	stmt.setString(1, fullname);
	stmt.executeUpdate();
    
	//System.out.println(fullname);
		
}
catch(Exception e) {
	System.out.println(e);
} finally {
	stmt.close();
	con.close();
}
%>