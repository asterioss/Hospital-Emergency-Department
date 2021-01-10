<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% String fullname = request.getParameter("fullname");
 String addr = request.getParameter("addr");
 String amkaa = request.getParameter("amka");
 String asff = request.getParameter("asf");
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
		if(rs.getString("xronia_nosimata").equals(" ")) System.out.println(rs.getString("amka") +" | "+rs.getString("onomatepwnumo") +" | "+ rs.getString("dieuthinsi") +": "+ rs.getString("asfalistikos_foreas")+" | "+rs.getString("plhrofories_prohgoumenwn_episkepsewn"));
		else System.out.println(rs.getString("amka") +" | "+rs.getString("onomatepwnumo") +" | "+ rs.getString("dieuthinsi") +": "+ rs.getString("asfalistikos_foreas")+" | "+rs.getString("xronia_nosimata")+" | "+rs.getString("plhrofories_prohgoumenwn_episkepsewn"));
		response.sendRedirect("patient.html");
    } else {
    	System.out.println("Den uparxei o asthenis.");
    	insert = con.prepareStatement("insert into dedomena_asthenwn(amka,onomatepwnumo,dieuthinsi,asfalistikos_foreas,xronia_nosimata,plhrofories_prohgoumenwn_episkepsewn)" +
    	"values(?,?,?,?,?,?)");
    	insert.setString(1, amkaa);
    	insert.setString(2, fullname);
    	insert.setString(3, addr);
    	insert.setString(4, asff);
    	insert.setString(5, "");
    	insert.setString(6, "");
    	
    	insert.executeUpdate();
    	System.out.println("O asthenis "+fullname+" prostethike me epituxia.");
    	response.sendRedirect("patient.html");
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