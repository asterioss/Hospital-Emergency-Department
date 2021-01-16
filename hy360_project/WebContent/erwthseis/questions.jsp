<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Erwthseis</title>
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
<form action="answer.jsp" method="post">
 <a href="../home_page.jsp">Home Page</a><br><br>
 <label for="erwthseis"><b>Erwthseis</b></label>
 <select name="questions" id="questions">
    <option value="katastasi_episkepsewn">Katastasi episkepsewn sto telos ths efimerias</option>
    <option value="statistika">Statistika ana efimeria kai ana mina</option>
    <option value="covid_report">covid-19 report</option>
    <option value="melh_proswpikou">Pote ergasthke to kathe melos</option>
 </select>
 
 <button type="submit" class="btn">Check the answer</button>
 
</form>
</body>
</html>