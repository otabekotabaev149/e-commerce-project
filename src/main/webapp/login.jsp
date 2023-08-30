<%@page import="java.util.ArrayList"%>
<%@page import="org.javacoders.connection.DbCon"%>
<%@page import="org.javacoders.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    	User auth = (User)request.getSession().getAttribute("auth");
	    if(auth != null){
	    	response.sendRedirect("index.jsp");
	    }
	    
	    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	    if(cart_list != null){
	    	request.setAttribute("cart_list", cart_list);
	    }
    %>
<!DOCTYPE html>
<html>
<head>
	<title>Shopping Card Login</title>
	<%@include file="include/head.jsp" %>
</head>
<body>
	<%@include file="include/navbar.jsp" %>
	
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">
				User Login
			</div>
			<div class="card-body">
				<form action="user-login" method="post">
					<div class="form-group">
						<label class="form-label">Email Address</label>
						<input type="email" class="form-control" name="login-email" placeholder="Enter your email" required>
					</div>
					<div class="form-group">
						<label class="form-label">Password</label>
						<input type="password" class="form-control" name="login-password" required>
					</div>
					<div class="text-center my-3">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<%@include file="include/footer.jsp" %>
</body>
</html>