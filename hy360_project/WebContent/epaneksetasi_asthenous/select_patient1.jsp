<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Epilogh Eksetaszomenou</title>
<style>
select {
   padding: 14px 20px;
   margin: 8px 0;
   width: 100%;
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
<body>
<form action="">
<h1 style="text-align:center;">Choose a patient from list</h1>
<%
 String url = new String("jdbc:mysql://localhost");
 String databaseName = new String("test");
 int port = 3306;
 String username = new String("root");
 String password = new String("");
 Connection con = null;
 Statement myStmt = null;
 PreparedStatement pat = null;
 ResultSet myRs = null;

 try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);

    myStmt = con.createStatement();

    myRs = myStmt.executeQuery("select * from eksetasi_patient");

    out.println("Astheneis pou exoun eksetastei:");
    out.println("<br>");
    while (myRs.next()) {
	   out.println(myRs.getString("onomatepwnumo"));
       out.println("<br>");
    }
    myRs.close();   

%>
<br><label for="patient"><b>Write the patient's name</b></label>
  <input type="text" placeholder="Enter Patient's Name" name="patient" id="patient" required>
  
 <button type="submit" class="eksetbtn">Pame gia epanksetasi</button>

</form>

</body>
</html>

<%
    String name = request.getParameter("patient");
    pat = con.prepareStatement("select * from eksetasi_patient where onomatepwnumo = ?");
    pat.setString(1, name);
    //System.out.println(name);

    myRs = pat.executeQuery();
    if(myRs.next()) {
       if(name!=null) {
         System.out.println(name);
         response.sendRedirect("epaneksetasi.jsp?name=" + name);
       }
    } else {
       if(name!=null) {
         out.println("Akuro onoma.");
       }
    }
    myRs.close();

 } catch(Exception e) {
	System.out.println(e);
 } finally {
     pat.close();
	 myStmt.close();
     con.close();
 }
%>