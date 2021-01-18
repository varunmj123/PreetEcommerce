<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="jdbc.jsp"%>
<%@ include file="auth.jsp"%>

<%


// TODO: Write SQL query that prints out total order amount by day
String SQL = "SELECT CONVERT(VARCHAR(10), getdate(), 111) AS orderDate ,SUM(totalAmount) AS totalAmount FROM ordersummary GROUP BY orderDate";

String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mdasilv;";
String uid = "mdasilv";
String pw = "23182165";


try(Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement()){
	
	ResultSet rs =  stmt.executeQuery(SQL);
	
	out.println("<table><tr><th>Order Date</th>");
	out.println("<th>Total Order Amount</th></tr> </table>");
	
	//print out the total order amounts grouped by date
	while(rs.next()){
		out.println("<tr> " + "<td> " + rs.getString("orderDate")+ "</td>" + "<td>" +rs.getDouble("totalAmount") + "</td>" + "</tr>");
		
	}
}

catch (SQLException ex) {
	out.println(ex);
}
finally{
	con.close();		//close the connection
}
%>

</body>
</html>

