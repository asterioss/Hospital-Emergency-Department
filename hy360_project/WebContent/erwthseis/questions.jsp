<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Erwthseis</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
</style>
</head>
<body>
<form action="answer.jsp" method="post">
 <div style="text-align:center">
   <a href="../home_page.jsp">Home Page</a><br><br>
 </div>
 
 <label for="autheraites"><b>Autheraites Erwthseis</b></label>
 <textarea id="anafora" name="anafora" rows="5" cols="100">
 </textarea> 
 
 <label for="erwthseis"><b>Prokathorismenes Erwthseis</b></label>
 <select name="questions" id="questions">
    <option value="katastasi_episkepsewn">Katastasi episkepsewn sto telos ths efimerias</option>
    <option value="statistika">Statistika ana efimeria kai ana mina</option>
    <option value="covid_report">Covid-19 report</option>
    <option value="melh_proswpikou">Pote ergasthke to kathe melos</option>
 </select>
 
 <button type="submit" class="btn">Check the answer</button>
 
</form>
</body>
</html>