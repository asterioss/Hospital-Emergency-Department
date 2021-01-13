<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>

<%
String diagnosi = (String)request.getParameter("diagnosis");
String farmako = (String)request.getParameter("farmaka");
out.println("Diagnosi: "+diagnosi+", Farmako: "+farmako);

//kanoume update ton pinaka kai vazoume diagnosi kai farmaka
%>
