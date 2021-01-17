<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="as2.css">
<meta charset="UTF-8">
<title>Login</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
</style>
</head>
<body>
 <form action="">
 <h1>Login</h1>
 
 <div class="container" style="padding:16px;">
 <label for="username"><b>Username</b></label>
   <input type="text" placeholder="Enter Username" name="username" id="username" required>
   
 <label for="psw"><b>Password</b></label>
   <input type="password" placeholder="Enter Password" name="psw" id="psw" required>
   
   <button type="submit" class="loginbtn">Login</button>
  </div>
 
 </form>

</body>
</html>

<% String name = request.getParameter("username");
 String pass = request.getParameter("psw");
 
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
	
	stmt = con.prepareStatement("select * from users where username = ? AND password = ?");
	stmt.setString(1, name);
	stmt.setString(2, pass);
	
	rs = stmt.executeQuery();
	if(rs.next()) {
        //succesfully logged in
        response.sendRedirect("home_page.jsp");
    } else {
    	if(name!=null && pass!=null) {
           out.println("Wrong username or password.");
    	}
    }

	//PrintWriter out = response.getWriter();
	//stmt.executeUpdate();
	//out.println("Registered Succesfully!");
	
	//response.sendRedirect("home_page.html");
	
 }
 catch(Exception e) {
	System.out.println(e);
 } finally {
	 rs.close();
	 stmt.close();
	 con.close();
 }

%>