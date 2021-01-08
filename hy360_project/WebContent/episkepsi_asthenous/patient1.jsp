<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% String fullname = request.getParameter("fullname");
 String addr = request.getParameter("addr");
 String amkaa = request.getParameter("amka");
 String asff = request.getParameter("asf");
 
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
	
	stmt = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
	stmt.setString(1, fullname);
	
	rs = stmt.executeQuery();
	if(rs.next()) {
		System.out.println("Uparxei o asthenis.");
        //response.sendRedirect("home_page.jsp");
    } else {
    	System.out.println("Den uparxei o asthenis.");
    }
	
 }
 catch(Exception e) {
	System.out.println(e);
 } finally {
	stmt.close();
	con.close();
 }


%>