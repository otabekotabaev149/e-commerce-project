<%@page import="java.text.DecimalFormat"%>
<%@page import="com.javacoders.dao.ProductDao"%>
<%@page import="java.util.*"%>
<%@page import="org.javacoders.connection.DbCon"%>
<%@page import="org.javacoders.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    	DecimalFormat dcf = new DecimalFormat("#.##");
    	request.setAttribute("dcf", dcf);
    	User auth = (User)request.getSession().getAttribute("auth");
	    if(auth != null){
	    	request.setAttribute("auth", auth);
	    }
	    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	    List<Cart> cartProduct = null;
	    if(cart_list != null){
	    	ProductDao pDao = new ProductDao(DbCon.getConnection());
	    	cartProduct = pDao.getCartProducts(cart_list);
	    	double total = pDao.getTotalCartPrice(cart_list);
	    	request.setAttribute("cart_list", cart_list);
	    	request.setAttribute("total", total);
	    }
    %>
<!DOCTYPE html>
<html>
<head>
	<title>Cart page</title>
	<%@include file="include/head.jsp" %>
	<style type="text/css">
		.table tbody td {
			vertical-align: middle;
		}
		.btn-incre, .btn-decre {
			box-shadow: none;
			font-size: 25px;
		}
	</style>
</head>
<body>
	<%@include file="include/navbar.jsp" %>
	<div class="container">
		<div class="d-flex py-3">
			<h3>Total Price: $${(total>0)?dcf.format(total):0}</h3>
			<a href="cart-check-out" class="btn btn-primary mx-3">Check Out</a>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy Now</th>
					<th scope="col">Cencel</th>
				</tr>
			</thead>
			<tbody>
			<%
				if(cart_list != null){
					for(Cart c : cartProduct){%>
					<tr>
						<td><%=c.getName()%></td>
						<td><%=c.getCategory()%></td>
						<td><%=dcf.format(c.getPrice())%>$</td>
						<td>
							<form action="order-now" method="post" class="form-inline">
								<input type="hidden" name="id" value="<%=c.getId()%>" class="form-input">
								<div class="form-group d-flex justify-content-between w-50">
									<a href="quantity-inc-dec?action=dec&id=<%=c.getId()%>" class="btn btn-sm btn-decre">
										<i class="fa-regular fa-square-minus" style="color: #0055ff;"></i>
									</a>
									<input type="text" name="quantity" class="form-control w-50" value="<%=c.getQuantity()%>" readonly>
									<a href="quantity-inc-dec?action=inc&id=<%=c.getId()%>" class="btn btn-sm btn-incre">
										<i class="fa-regular fa-square-plus" style="color: #0055ff;"></i>
									</a>
									<button type="submit" class="btn btn-primary btn-sm">Buy</button>
								</div>
								
							</form>
						</td>
						<td><a href="remove-from-cart?id=<%=c.getId()%>" class="btn btn-sm btn-danger">Remove</a></td>
					</tr>
					<%}
				}
			%>
			</tbody>
		</table>
	</div>
	<%@include file="include/footer.jsp" %>
</body>
</html>