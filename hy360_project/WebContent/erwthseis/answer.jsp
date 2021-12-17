<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../as2.css">
<meta charset="ISO-8859-1">
<title>Answer</title>
<style>
 body {font-family: Arial, Helvetica, sans-serif;}
</style>
</head>
<body>
<form action="questions.jsp">

<%
String url = new String("jdbc:mysql://localhost");
String databaseName = new String("test");
int port = 3306;
String username = new String("root");
String password = new String("");
Connection con = null;
PreparedStatement stmt = null;
PreparedStatement temp = null;
PreparedStatement skata = null;
PreparedStatement ekei = null;
Statement myStmt = null;
Statement Stmt = null;
Statement mystmt = null;
ResultSet Myrs = null;
ResultSet rs = null;
ResultSet myrs = null;
ResultSet pame = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection(
	url + ":" + port + "/" + databaseName + "?characterEncoding=UTF-8", username, password);
	
	String question = (String)request.getParameter("questions"); 
	//System.out.println(question);
	if(question.equals("katastasi_episkepsewn")) {
		myStmt = con.createStatement();
		
		myrs = myStmt.executeQuery("select * from dedomena_asthenwn");
		
		out.println("Oi shmerines episkepseis:");
	    out.println("<br>");
	    out.println("<br>");
		while (myrs.next()) {
			out.println("O asthenis " +myrs.getString("onomatepwnumo")+ " episkeftike to TEP me symptomata: " + myrs.getString("symptoms"));
		    out.println("<br>");
		}
		myrs.close();
		myStmt.close();
		
		Stmt = con.createStatement();
        rs = Stmt.executeQuery("select * from nosileuomenoi_astheneis");
		
		while (rs.next()) {
			out.println("O asthenis " +rs.getString("onomatepwnumo")+ " episkeftike to TEP me symptomata: " + rs.getString("symptoms"));
		    out.println("<br>");
		}
		rs.close();
		Stmt.close();
	}
	else if(question.equals("statistika")) {
		//estw oti exoume 5 tou mhna
		int x=0;  //index gia astheneis
		int i=0, j=1;
		out.println("Ianouarios");
		out.println("<br>");
		out.println("<br>");
			
		myStmt = con.createStatement();
			
		rs = myStmt.executeQuery("select * from dedomena_asthenwn");
		int peristatika=0;
		ArrayList<String> astheneies = new ArrayList<String>();
		ArrayList<String> farmaka = new ArrayList<String>();
		while (rs.next()) {
		   if(x<2) {
			if(i%2==0) {
			  out.println("Hmera "+j+", Efhmeria 2:");
			  out.println("<br>");
			  out.println("Arithmos peristatikwn: 1");
			  out.println("<br>");
			  out.println("Astheneies: allergia");
			  out.println("<br>");
			  out.println("Farmaka: xozal");
			}
			else {
			  out.println("Hmera "+j+", Efhmeria 1:");
			  out.println("<br>");
			  out.println("Arithmos peristatikwn: 3");
			  out.println("<br>");
			  out.println("Astheneies: gastrenteritida allergia covid-19");
			  out.println("<br>");
			  out.println("Farmaka: prodiac xozal ponstan00");
			}
			out.println("<br>");
			out.println("<br>");
		   }
		   i++;
		   if(j<=2) j++;
		   x++;
		   if(x>=2) {
			   if(x==2) {
				   out.println("Hmera "+j+", Efhmeria 1 (Twra):");
				   Stmt = con.createStatement();
				   myrs = Stmt.executeQuery("select * from eksetazomenoi_astheneis");
				   
				   mystmt = con.createStatement();
				   Myrs = mystmt.executeQuery("select * from nosileuomenoi_astheneis");
				   
				   out.println("<br>");
			   }
			   
			   while (myrs.next()) {
				   peristatika++; 
				   if(!myrs.getString("diagnosis").equals("")) {
					   astheneies.add(myrs.getString("diagnosis"));
				   }
				   if(!myrs.getString("farmakeutikh_agwgh").equals("")) {
					   farmaka.add(myrs.getString("farmakeutikh_agwgh"));
				   }
			   }
			   //myrs.close();
			   //Stmt.close();
			  
			   while (Myrs.next()) {
				   peristatika++; 
				   if(!Myrs.getString("diagnosis").equals("")) {
					   astheneies.add(Myrs.getString("diagnosis"));
				   }
				   if(!Myrs.getString("farmakeutikh_agwgh").equals("")) {
					   farmaka.add(Myrs.getString("farmakeutikh_agwgh"));
				   }
			   }
			   
			   //out.println("<br>");
			   //out.println(rs.getString("onomatepwnumo"));
		    }
		}
		out.println("Arithmos peristatikwn: "+peristatika);
		out.println("<br>");
		out.println("Astheneies: ");
		for(int index=0; index<astheneies.size(); index++) {
			 out.println(astheneies.get(index));
		}
		out.println("<br>");
		out.println("Farmaka: ");
		for(int index=0; index<farmaka.size(); index++) {
			 out.println(farmaka.get(index));
		}
		out.println("<br>");
		
		Myrs.close();
		mystmt.close();
		myrs.close();
		Stmt.close();
		rs.close();
		myStmt.close();
			
		//System.out.println("ekei");
	}
	else if(question.equals("covid_report")) {
		//System.out.println("ekei");
		
		stmt = con.prepareStatement("select * from eksetazomenoi_astheneis where diagnosis = ?");
		stmt.setString(1, "covid-19");
		rs = stmt.executeQuery();
		
		skata = con.prepareStatement("select * from nosileuomenoi_astheneis where diagnosis = ?");
		skata.setString(1, "covid-19");
		
		Myrs = skata.executeQuery();
		
		out.println("Oi astheneis pou exoun covid-19:");
	    out.println("<br>");
	    out.println("<br>");
		while (rs.next()) {
			temp = con.prepareStatement("select * from dedomena_asthenwn where onomatepwnumo = ?");
			temp.setString(1, rs.getString("onomatepwnumo"));
			
			myrs = temp.executeQuery();
			
			String nosima = "";
			if(myrs.next()) {
			  nosima = myrs.getString("xronia_nosimata");
			}
			temp.close();
			myrs.close();
			
			out.println("O asthenis " +rs.getString("onomatepwnumo")+ " diagnwstike me covid-19 ");
			if(nosima.equals("")) {
				out.println(" kai den exei xronia nosimata"); 
			}
			else {
				out.println(" kai exei xronia nosimata: " + nosima); 
			}
			out.println("<br>");
			
		}
		while (Myrs.next()) {			
			String nosima ="";
          	nosima = Myrs.getString("xronia_nosimata");
			
			out.println("O asthenis " +Myrs.getString("onomatepwnumo")+ " diagnwstike me covid-19 ");
			if(nosima.equals("")) {
				out.println(" kai den exei xronia nosimata"); 
			}
			else {
				out.println(" kai exei xronia nosimata: " + nosima); 
			}
			out.println("<br>");
			
		}
		skata.close();
		Myrs.close();
		stmt.close();
		rs.close();
	}
	else if(question.equals("melh_proswpikou")) {
		myStmt = con.createStatement();
		
		rs = myStmt.executeQuery("select * from dedomena_prosopikou");
		
		int i=0;
		String efhmeria="prwinh efhmeria";
		out.println("Oi efhmeries pou ergasthke kathe melos tou proswpikou:");
		out.println("<br>");
		out.println("<br>");
		while (rs.next()) {
			i++;
			out.println(rs.getString("onomatepwnumo")+" ("+efhmeria+", 15 efhmeries)");
			out.println("<br>");
			if(i==9) {
			   out.println("<br>");
			   efhmeria="vradinh efhmeria";
			}
		}
		skata.close();
		Myrs.close();
		myStmt.close();
		rs.close();
	}
	
}
catch(Exception e) {
	System.out.println(e);
} finally {
	//rs.close();
	//stmt.close();
	con.close();
}
%>

<br><button type="submit" class="btn">Go back</button>

</form>
</body>
</html>