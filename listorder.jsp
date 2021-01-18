<%@ page import="java.sql.*"%>

<%@ page import="java.text.NumberFormat"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>

<html>

<head>

<title> UlaanBazaar Grocery Order List</title>

</head>

<body>



	<h1 style="color:Tomato;">Order list</h1>



	<%

		//Note: Forces loading of SQL Server driver

		try { // Load driver class

			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		} catch (java.lang.ClassNotFoundException e) {

			out.println("ClassNotFoundException: " + e);

		}

	

	/* SELECT orderId,orderDate,customerId,firstName+' '+lastName,totalAmount */

	

		/* String SQL = "SELECT orderId,orderDate,customer.customerId,ordersummary.customerId,CONCAT('firstName','lastName') AS CustomerName,totalAmount"

				+ "FROM customer,ordersummary WHERE customer.customerId = ordersummary.customerId"; */

				

				/* "FROM customer JOIN ordersummary WHERE customer.customerId = ordersummary.customerId ORDER BY orderId ASC" */

				

		String SQL = "SELECT orderId, orderDate, ordersummary.customerId, CONCAT(firstName,' ' ,lastName ) AS customerName, totalAmount FROM ordersummary, customer WHERE ordersummary.customerId=customer.customerId ORDER BY orderId ASC";

		

				

		String SQL2 = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ? ORDER BY productId ASC ";

		

		
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mdasilv;";
		String uid = "mdasilv";
		String pw = "23182165";

		

		NumberFormat currformat = NumberFormat.getCurrencyInstance();

	

		try (Connection con = DriverManager.getConnection(url, uid, pw);

				Statement stmt = con.createStatement();

				PreparedStatement pstmt = con.prepareStatement(SQL2)) {

	

			

			ResultSet rst = stmt.executeQuery(SQL);

			ResultSet rst2;

			/* style= 'color:#008080' >  */

					

			out.println("<table border = '1'><tbody> <tr><th style= 'color:#008080'> Order Id </th>");

			out.println("<th style= 'color:#008080'> Order Date </th>");

			out.println("<th style= 'color:#008080'> Customer Id </th>");

			out.println("<th style= 'color:#008080'> Customer Name </th>");

			out.println("<th style= 'color:#008080'> Total Amount </th></tr>");

			

			while (rst.next()) {

				

				pstmt.setInt(1, rst.getInt("orderId"));

				rst2 = pstmt.executeQuery();

				

				out.println("<tr> <td>" + rst.getString("orderId") + "</td>" + "<td>" + rst.getDate("orderDate") + "</td>" + "<td>" + rst.getInt("customerId") + "</td>"

						 + "<td>" + rst.getString("customerName")+"</td>" + "<td>"+ rst.getDouble("totalAmount") + "</td></tr>");

				

				/* out.println("<tr><td colspan = '5'><table border = '1'> <tr><th style= 'color:#008080'>Product Id</th> <th style= 'color:#008080'>Quantity</th> <th style= 'color:#008080'>Price</th></tr></td>" ); */

				while(rst2.next()){

					

					

					

					out.println("<tr><td colspan = '5'><table border = '1'> <tr><th style= 'color:#008080'>Product Id</th> <th style= 'color:#008080'>Quantity</th> <th style= 'color:#008080'>Price</th></tr></td>" );

					

					out.println("<tr><td>" + rst2.getInt("productId") + "</td>" +"<td>" + rst2.getInt("quantity" ) + "</td>" + "<td>" + currformat.format(rst2.getDouble("price"))+ "</td></tr></tbody></table></tr>");

				

				}

				

				

				

			}

			out.println("</table>");

			con.close();

			

								//closing the connection

			

		} catch (SQLException ex) {

			out.println(ex);

		}



		// Useful code for formatting currency values:

		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		// out.println(currFormat.format(5.0);  // Prints $5.00



		// Make connection



		// Write query to retrieve all order summary records



		// For each order in the ResultSet



		// Print out the order summary information

		// Write a query to retrieve the products in the order

		//   - Use a PreparedStatement as will repeat this query many times

		// For each product in the order

		// Write out product information 



		// Close connection

	%>






</body>

</html>