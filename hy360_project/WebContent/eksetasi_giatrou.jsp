<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Eksetasi apo Giatro</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
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
</style>
</head>
<body>
<form action="eksetasi_nosileutikou.jsp" method="post">
<%
String url = new String("jdbc:mysql://localhost");
String databaseName = new String("test");
int port = 3306;
String username = new String("root");
String password = new String("");
Connection con = null;
PreparedStatement stmt = null;
PreparedStatement create = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	String name = request.getParameter("name");
	//System.out.println("Name: "+name);
	stmt = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
	stmt.setString(1, name);
	
	rs = stmt.executeQuery();
	
	if(rs.next()) {
	   out.println("O asthenis " +name+ " eisilthe sto TEP me symptomata: " + rs.getString("symptoms"));
	}
	else {
		System.out.println("Something gone wrong.");
	}
	rs.close();
	//stmt.close();
  
%>
  <br><br><label for="diagnosis"><b>Diagnosis</b></label>
  <select name="diagnosis" id="diagnosis">
    <option value="arithmies">Arithmies</option>
    <option value="covid-19">Covid-19</option>
    <option value="covid-20">Covid-20</option>
    <option value="gastrederitida">Gastrederitida</option>
    <option value="provlima_orasis">Provlima Orasis</option>
    <option value="gripi">Gripi</option>
    <option value="katagma">Katagma</option>
    <option value="allergia">Allergia</option>
    <option value="kruologhma">Kruologhma</option>
  </select>
  
  <button type="button" class="farmakabtn" onclick="change_display()">Farmakeutikh Agwgh(proairetiko)</button>
  
  <select name="farmaka" id="farmaka" style="display:none;">
    <option selected=""> </option>
    <option value="depon00">Depon (xapi)</option>
    <option value="depon01">Depon (siropi)</option>
    <option value="mesulid">Mesulid (xapi)</option>
    <option value="prodiac">Prodiac (kapsoula)</option>
    <option value="ponstan00">Ponstan (xapi)</option>
    <option value="ponstan01">Ponstan (siropi)</option>
    <option value="artelac">Artelac (stagones)</option>
    <option value="arichol">Arichol (xapi))</option>
    <option value="bisolvon00">Bisolvon (xapi)</option>
    <option value="bisolvon01">Bisolvon (siropi)</option>
    <option value="xanax">Xanax (xapi)</option>
    <option value="xozal">Xozal (xapi)</option>
  </select>
  
  <input type="hidden" name="patient_name" value=<%=name%>>
  
  <button type="submit" class="eksetasibtn">Eksetasi apo nosileutiko</button>

<script>
 function change_display() {
     document.getElementById("farmaka").style.display = "block";
 }
</script>
</form>
</body>
</html>

<% 
  String diagnosi = (String)request.getParameter("diagnosis");
  String farmako = (String)request.getParameter("farmaka");
  String arrayString[] = name.split("\\s+");   //split sting by space
  String first_name = arrayString[0];
 
  create = con.prepareStatement("CREATE TABLE IF NOT EXISTS eksetasi_patient " +
         "(onomatepwnumo VARCHAR(255) not NULL, " +
         " name VARCHAR(255) not NULL, " + 
         " diagnosis VARCHAR(255) DEFAULT NULL, " + 
         " farmakeutikh_agwgh VARCHAR(255) DEFAULT NULL, " + 
         " anafora VARCHAR(255) not NULL, " + 
         " PRIMARY KEY ( onomatepwnumo ))");
  create.executeUpdate();
   //System.out.println(farmako);
  create.close();
 
  stmt = con.prepareStatement("insert into eksetasi_patient(onomatepwnumo,name) values(?,?)");
  stmt.setString(1, name);
  stmt.setString(2, first_name);
  //stmt.setString(2, diagnosi);
  //if(farmako!=null) stmt.setString(3, farmako);
 
  stmt.executeUpdate();
 
 }
 catch(Exception e) {
	System.out.println(e);
 } finally {
	 stmt.close();
	 //rs.close();
	 con.close();
 }

%>