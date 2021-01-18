<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>

<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset =UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ulaanbaazar Grocery Order Processing</title>
</head>
<body>
	<h1 style="color: blue">Your Order Summary</h1>
	
<%
		// Get customer id
		String custId = request.getParameter("customerId");
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		// Make connection
		try {
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mdasilv;";
			 String uid = "mdasilv";
			 String pw = "23182165";
			Connection con = DriverManager.getConnection(url, uid, pw);
			//Determine if valid customer id was entered
			//Determine if there are products in the shopping cart
			//If either are not true, display an error message

			String sql = "SELECT customerId FROM customer WHERE customerId = ?";

			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, custId);
			boolean validId = stmt.execute(sql);
			if (validId) {
				if (productList == null){
					out.println("<h1>Product list empty. Go back to the previous page and try again.</h1>");
				}
					
			} else
				out.println("<h1>Invalid customer ID. Go back to the previous page and try again.</h1>");

			// Save order information to database
			Statement stmt2 = con.createStatement();
			ResultSet rs1 = stmt2.executeQuery("SELECT FROM customer");
			String sql2 = "INSERT INTO ordersummary VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ppstmt = con.prepareStatement(sql2);
		/* 	DateFormat df = new SimpleDateFormat("dd/MM/yy"); */
						
			/* java.sql.Date today = Time.valueOf(Date.ge); */ //get date
			Date today = new Date();
			String todayis = today.toString();		
						
			Calendar cal = Calendar.getInstance();
			Date temp = cal.getTime();

			Double totalSum = 0.0;
			
			ppstmt.setString(1, "orderId"); //replace orderId with var form
			ppstmt.setString(2, todayis); //having issues with date format //try with string
			ppstmt.setDouble(3, totalSum);
			ppstmt.setString(4, rs1.getString(6));
			ppstmt.setString(5, rs1.getString(7));
			ppstmt.setString(6, rs1.getString(8));
			ppstmt.setString(7, rs1.getString(9));
			ppstmt.setString(8, rs1.getString(10));
			ppstmt.setInt(9, rs1.getInt(1));

			// Use retrieval of auto-generated keys.
			PreparedStatement pstmt = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);
			ResultSet keys = pstmt.getGeneratedKeys();
			//keys.next();
			//int orderId = keys.getInt(1);

			// Insert each item into OrderProduct table using OrderId from previous INSERT
			int orderId, orderNum, quantity;
			double price, totalAmt;
			totalAmt = 0;
					
			while (keys.next()) {
				orderId = keys.getInt(1);
				orderNum = keys.getInt(2);
				quantity = keys.getInt(3);
				price = keys.getDouble(4);
				// Update total amount for order record
				totalAmt += quantity * price; //INSERT INTO ordersummary
				sql2 = "INSERT INTO orderproduct VALUES (?, ?, ?, ?)";
				ppstmt = con.prepareStatement(sql2);
				ppstmt.setInt(1, orderId);
				ppstmt.setInt(2, orderNum);
				ppstmt.setInt(3, quantity);
				ppstmt.setDouble(4, price);
				
				out.println("<tr><th>Product Id </th> <th> Product Name</th> <th > Quantity </th> <th>Price </th> <th>Subtotal </th></tr>");
				
			}
				
				
			// Here is the code to traverse through a HashMap
			// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

			/*
				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext())
				{ 
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
					String productId = (String) product.get(0);
			String price = (String) product.get(2);
					double pr = Double.parseDouble(price);
					int qty = ( (Integer)product.get(3)).intValue();
			...
				}
			*/
		
			// Print out order summary
			/* while(keys.next()){
				out.print();
			} */
			// Clear cart if order placed successfully
		} catch (SQLException e) {
			System.err.println(e);
		}
	%>
</BODY>
</HTML>

