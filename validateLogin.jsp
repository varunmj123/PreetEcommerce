<%@ page language="java"%>
<%@ import="java.io.*"%>
<%@ import = "java.sql.*"%>
<%@ include file = "jdbc.jsp" %>

 <%
	String authenticatedUser = null;
	session = request.getSession(true);
	
	private String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_mdasilv;";
	private String uid = "mdasilv";
	private String pw = "23182165";

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		out.println(" failed to login!");
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%
	String validateLogin( JspWriter out,HttpServletRequest request, HttpSession session ) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			
			getConnection();
			Connection con = DriverManager.getConnection(url, uid, pw);
			
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			String sql = ("SELECT userid, password FROM customer WHERE userid= ? AND password = ?");
			
			
			
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,username);
			pstmt.setString(2,password);
			ResultSet rs = pstmt.executeQuery();
			

			
		if(username == rs.getString(1))
			retStr = username;			
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>