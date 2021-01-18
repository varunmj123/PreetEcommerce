<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>

<html>

<head>

<title>Ulaan Bazaar</title>

</head>

<body style="background-color: #F9CF02;">



	<h1 align="center">
		<font face="Futura"><font color="C4272F">Browse through
				our authentic Mongolian products:</font></font>
	</h1>


	<form method="get" action="listprod.jsp">

		<input type="text" name="productName" size="50"> <input
			type="submit" value="Submit"><input type="reset"
			value="Reset"> (Leave blank for all products)

	</form>


	<%
		// Get product name to search for

		//Note: Forces loading of SQL Server driver

		try

		{ // Load driver class

			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		}

		catch (java.lang.ClassNotFoundException e)

		{

			out.println("ClassNotFoundException: " + e);

		}

		String name = request.getParameter("productName");

		String price = request.getParameter("productPrice");

		 String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mdasilv;";
		 String uid = "mdasilv";
		 String pw = "23182165";

		Connection con = DriverManager.getConnection(url, uid, pw);

		// Load driver class

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		String sql = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE '%' + ? + '%'";
		//String sql = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?";

		//boolean hasName = name!=null && !name.equals("");

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, name);

		ResultSet rs = ps.executeQuery();

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		out.println("<table> <tr><th>product name</th> <th>price</th></tr>");

		while (rs.next()) {

			//ps = con.prepareStatement(sql);

			//rs = ps.executeQuery();

			out.println("<tr>" + "<td><a href=\"addcart.jsp?id=" + rs.getInt(1) + "&name=" + rs.getString(2)
					+ "&price=" + rs.getString(3) + "\"   Add to cart</a>" + rs.getString(2) + "  "
					+ currFormat.format(rs.getDouble(3)) + "</tr>");

		}

		con.close();
	%>


</body>

</html>