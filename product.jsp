<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String sql = "SELECT * FROM product WHERE productId = ?";

// TODO: If there is a productImageURL, display using IMG tag
try{
	int idTag = Integer.parseInt(productId);
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1,idTag);
	ResultSet rst = pstmt.executeQuery();
	out.println("<h1>" + rst.getString("productName") + "</h1>");
	// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
	
	
	//USE displayImage.jsp INSTEAD
	
	out.println("<img src =" + rst.getString("productImageURL")+" >"); 
	out.println("<table><tr><th>Id" + rst.getString("productId") + "</th>");
	out.println("<th>Price" + rst.getString("productPrice") + "</th></tr></table>");
	
	out.println("<a href= 'addcart.jsp' title= 'add to cart' >");

	
	
	// TODO: Add links to Add to Cart and Continue Shopping
	//USE BUTTONS SO WE DON'T HAVE TO CHANGE FOR LAB 10
}catch(Exception e){
	out.println("Invalid product id: "+productId+" Error: "+e);
	return;
}	

%>

</body>
</html>

