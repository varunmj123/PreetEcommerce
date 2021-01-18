
<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.lang.ClassNotFoundException" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>
	
<%

// TODO: Print Customer information
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mdasilv;";
	String uid = "mdasilv";
	String pw = "23182165";
	if (userName==null){
		out.println("<h1>Please login into system</h1>");
		response.sendRedirect("login.jsp");
	}
	
	try (Connection con = DriverManager.getConnection(url, uid, pw);
		 Statement stm = con.createStatement();){
			String sql = "SELECT * FROM customer WHERE userid = "+ userName;
			ResultSet rs = stm.executeQuery(sql);
			out.println("<table>");
			out.println("<tr><th>Id</th><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>User id</th>");
			out.println("<tr><td>rs.getString(1)</td><td>rs.getString(2)</td><td>rs.getString(3)</td><td>rs.getString(4)</td><td>rs.getString(5)</td><td>rs.getString(6)</td><td>rs.getString(7)</td><td>rs.getString(8)</td><td>rs.getString(9)</td><td>rs.getString(10)</td><td>rs.getString(11)</td></tr>");
			out.println("</table>");

	}
	catch (Exception e)
	{
		out.println(" ClassNotFoundException: " +e);
	}
	finally{
		con.close();
	}

// Make sure to close connection
%>

</body>
</html>
