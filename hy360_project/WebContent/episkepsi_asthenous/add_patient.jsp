<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Episkepsi Asthenous</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
 input[type=text] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
 }
 button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
 }
 select {
   padding: 14px 20px;
   margin: 8px 0;
   width: 100%;
 }
</style>
</head>
<body>
<form action="add_patient.jsp" method="post">
 <h1 style="text-align:center;">Episkepsi Asthenous</h1>
 <a href="../home_page.jsp">Home Page</a>
 <div class="container" style="padding:16px;">
 <label for="fullname"><b>Username</b></label>
   <input type="text" placeholder="Enter Fullname" name="fullname" id="fullname" required>
   
 <label for="addr"><b>Address</b></label>
   <input type="text" placeholder="Enter Address" name="addr" id="addr" required>
   
 <label for="amka"><b>Amka</b></label>
   <input type="text" placeholder="Enter AMKA" name="amka" id="amka" required>
   
 <label for="asf_for"><b>Asfalistikos Foreas</b></label>
   <input type="text" placeholder="Enter Asfalistiko Forea" name="asf" id="asf" required>
   
 <label for="nosimata"><b>Asfalistikos Foreas</b></label>
   <input type="text" placeholder="Enter Xronia Nosimata (if you have)" name="xr_nos" id="xr_nos">
   
 <label for="symptoms"><b>Choose a Symptom</b></label><br>
  <select name="symptoms" id="symptoms">
    <option value="ponokefalos">Ponokefalos</option>
    <option value="puretos">Puretos</option>
    <option value="ponolaimos">Ponolaimos</option>
    <option value="ponos">Ponos</option>
    <option value="provima_sta_matia">Provlima sta matia</option>
    <option value="ponos_stin_kardia">Ponos stin kardia</option>
    <option value="allergies">Allergies</option>
    <option value="ponokoilos">Ponokoilos</option>
  </select>
   
   <button type="submit" class="addbtn">Add Patient</button>
 </div>
 
 
</form>
</body>
</html>    

<%
 String fullname = request.getParameter("fullname");
 String addr = request.getParameter("addr");
 String amkaa = request.getParameter("amka");
// System.out.println(amkaa);
 String asff = request.getParameter("asf");
 String nosimata = " ";
 if(request.getParameter("xr_nos")!=null) {
	nosimata = request.getParameter("xr_nos");
 }
 String symptom = (String)request.getParameter("symptoms");
 
 String url = new String("jdbc:mysql://localhost");
 String databaseName = new String("test");
 int port = 3306;
 String username = new String("root");
 String password = new String("");
 Connection con = null;
 PreparedStatement stmt = null;
 PreparedStatement insert = null;
 ResultSet rs = null;

 try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	stmt = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
	stmt.setString(1, fullname);
	
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		out.println("O asthenis "+fullname+" uparxei.");
		out.println("<br>");
		if(rs.getString("xronia_nosimata").equals("")) out.println("Amka:"+rs.getString("amka")+" | Onomatepwnumo:"+rs.getString("onomatepwnumo")+" | Dieuthinsi:"+ rs.getString("dieuthinsi")+" | Asfalistikos Foreas:"+ rs.getString("asfalistikos_foreas"));
		else out.println("Amka:"+rs.getString("amka")+" | Onomatepwnumo:"+rs.getString("onomatepwnumo")+" | Dieuthinsi:"+ rs.getString("dieuthinsi")+" | Asfalistikos Foreas:"+ rs.getString("asfalistikos_foreas")+" | Xronia Nosimata:"+rs.getString("xronia_nosimata"));
		//response.sendRedirect("add_patient.html");
    } else {
    	System.out.println("Den uparxei o asthenis.");
    	
    	insert = con.prepareStatement("insert into dedomena_asthenwn(amka,onomatepwnumo,dieuthinsi,asfalistikos_foreas,xronia_nosimata,symptoms)" +
    	"values(?,?,?,?,?,?)");
    	insert.setString(1, amkaa);
    	insert.setString(2, fullname);
    	insert.setString(3, addr);
    	insert.setString(4, asff);
    	insert.setString(5, nosimata);
    	insert.setString(6, symptom);
    	
    	insert.executeUpdate();
    	out.println("O asthenis "+fullname+" prostethike me epituxia.");
    	//response.sendRedirect("add_patient.html");
    	insert.close();
    	
    }
	
 }
 catch(Exception e) {
	System.out.println(e);
 } finally {
	rs.close();
	stmt.close();
	con.close();
 }


%>