<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="shortcut icon" href="#">

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #fff;
    margin: 0;
    padding: 0;
    color: #333;
}

header {
    background-color: #f8f8f8;
    padding: 20px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

header h1 {
    margin: 0;
    font-size: 2em;
    color: #333;
}

nav {
    display: flex;
    justify-content: center;
    background-color: #f4f4f4;
    padding: 10px 0;
    border-bottom: 1px solid #ddd;
}

nav a {
    text-decoration: none;
    color: #333;
    margin: 0 20px;
    font-size: 1.2em;
}

nav a:hover {
    color: #007bff;
}

.container {
    padding: 30px;
    text-align: center;
}

footer {
    background-color: #f8f8f8;
    text-align: center;
    padding: 10px;
    border-top: 1px solid #ddd;
    position: fixed;
    width: 100%;
    bottom: 0;
}
</style>
</head>

<body>

	<!-- Link to go back to Product Management Page -->
	<nav class="navbar navbar-expand-md navbar-light">
		<br>
		<ul class="navbar-nav">
			<li><a
				href="<%=request.getContextPath()%>/ProductServlet/dashboard" class="btn btn-success">Back to Product Management
			</a></li>
		</ul>
	</nav>

	<div class="container col-md-6">
		<div class="card">
			<div class="card-body">

				<h2>Edit Product</h2>
				<br>
				<!-- Form fields to edit product -->
				<form action="${pageContext.request.contextPath}/ProductServlet/update" method="POST">
					<!-- Original Product ID field (hidden) -->
					<input type="hidden" name="oriPid" value="${Product.pid}" />
					
					<!-- Product ID field -->
					<div class="form-group">
						<label for="pid">Product ID:</label> <input type="text" name="pid" value="${Product.pid}" size="28" required>
					</div>
					
					<!-- Product Name field -->
					<div class="form-group">
						<label for="pname">Product Name:</label> <input type="text" name="pname" value="${Product.pname}" size="25" required>
					</div>
					
					<!-- Product Quantity field -->
					<div class="form-group">
						<label for="pqty">Product Quantity:</label> <input type="text" name="pqty" value="${Product.pqty}" size="23" required>
					</div>
					
					<!-- Supplier Price field -->
					<div class="form-group">
						<label for="price">Supplier Price</label> <input type="text" name="price" value="${Product.price}" size="25" required>
					</div>
					
					<!-- Save Button -->
					<button type="submit" class="btn btn-success">Save</button>
				</form>

			</div>
		</div>
	</div>
</body>
</html>
