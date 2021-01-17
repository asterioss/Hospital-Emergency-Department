<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Eksetasi apo Giatro</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
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
Statement temp = null;
PreparedStatement stmt = null;
PreparedStatement create = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	temp = con.createStatement();
	
	String name = request.getParameter("name");
	//System.out.println("Name: "+name);
	stmt = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
	stmt.setString(1, name);
	
	rs = stmt.executeQuery();
	String symptom = "";
	
	if(rs.next()) {
	   out.println("O asthenis " +name+ " eisilthe sto TEP me symptomata: " + rs.getString("symptoms")+".");
	   out.println("<br>");
	   symptom = rs.getString("symptoms");
	}
	else {
		System.out.println("Something gone wrong.");
	}
	rs.close();
	stmt.close();
	System.out.println(symptom);
	
	
	String eidik = "";
	
	if(symptom.equals("ponokefalos") || symptom.equals("puretos") || symptom.equals("ponolaimos")) {
		System.out.println("skata");
		eidik = "genikos";
	}
	else if(symptom.equals("ponos")){
		eidik = "orthopedikos";
	}
    else if(symptom.equals("provlima_sta_matia")){
    	eidik = "ofthalmiatros";
	}
    else if(symptom.equals("ponos_stin_kardia")){
    	eidik = "kardiologos";
	}
    else if(symptom.equals("allergies")){
    	eidik = "allergiologos";
	}
    else if(symptom.equals("ponokoilos")){
    	eidik = "gastrenterologos";
	}
    else {
    	System.out.println("Den uparxei sugkekrimenos giatros.");
    }
	//System.out.println(eidik);
	stmt = con.prepareStatement("select * from dedomena_prosopikou where ekseidikikeusi = ?");
	stmt.setString(1, eidik);
	
    rs = stmt.executeQuery();
	
	if(rs.next()) {
	   out.println("<br>");
	   out.println("O katallilos giatros einai o "+rs.getString("onomatepwnumo")+" me eidikeusi: "+rs.getString("ekseidikikeusi")+".");
	}
	else {
		System.out.println("Something gone wrong.");
	}
	rs.close();
	stmt.close();
	
	
	
  
%>
  <br><br><label for="diagnosis"><b>Diagnosis</b></label>
  <select name="diagnosis" id="diagnosis">
  <%rs = temp.executeQuery("select * from astheneies_kai_diagnosi"); 
	while (rs.next()) {%>
    <option value=<%=rs.getString("onoma_astheneias")%>><%=rs.getString("onoma_astheneias")%></option>
  <% } 
    rs.close();%>
    <!--<option value="covid-19">Covid-19</option>
    <option value="covid-20">Covid-20</option>
    <option value="gastrederitida">Gastrederitida</option>
    <option value="provlima_orasis">Provlima Orasis</option>
    <option value="gripi">Gripi</option>
    <option value="katagma">Katagma</option>
    <option value="allergia">Allergia</option>
    <option value="kruologhma">Kruologhma</option>-->
  </select>
  
  <button type="button" class="farmakabtn" onclick="change_display()">Farmakeutikh Agwgh(proairetiko)</button>
  
  <select name="farmaka" id="farmaka" style="display:none;">
    <option selected=""></option>
    <%rs = temp.executeQuery("select * from eksetaseis_kai_farmaka"); 
	while (rs.next()) {%>
    <option value=<%=rs.getString("onoma_diathesimou_farmakou")%>><%=rs.getString("onoma_diathesimou_farmakou")%>(<%=rs.getString("tupos_farmakou")%>) katallilo gia: <%=rs.getString("katallilo_gia")%></option>
    <% } 
    rs.close();%>
    <!--<option value="depon00">Depon (xapi)</option>
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
    <option value="xozal">Xozal (xapi)</option>-->
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
  String arrayString[] = name.split("\\s+");   //split sting by space
  String first_name = arrayString[0];
 
  create = con.prepareStatement("CREATE TABLE IF NOT EXISTS eksetazomenoi_astheneis " +
         "(onomatepwnumo VARCHAR(255) not NULL, " +
         " name VARCHAR(255) not NULL, " + 
         " diagnosis VARCHAR(255) DEFAULT NULL, " + 
         " farmakeutikh_agwgh VARCHAR(255) DEFAULT NULL, " + 
         " anafora VARCHAR(255) DEFAULT NULL, " + 
         " PRIMARY KEY ( onomatepwnumo ))");
  create.executeUpdate();
   //System.out.println(farmako);
  create.close();
 
  stmt = con.prepareStatement("insert into eksetazomenoi_astheneis(onomatepwnumo,name) values(?,?)");
  stmt.setString(1, name);
  stmt.setString(2, first_name);
 
  stmt.executeUpdate();
  stmt.close();
 
 }
 catch(Exception e) {
	System.out.println(e);
 } finally {
	 temp.close();
	 stmt.close();
	 rs.close();
	 con.close();
 }

%>