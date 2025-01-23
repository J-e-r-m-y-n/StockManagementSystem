<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Product</title>

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

	<!-- Link to go back to Product Management page -->
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

				<h1>Add New Product</h1>
				<br>
				
				<!-- Form fields to add new product -->
				<form action="ProductAddServlet" method="Post">
					Product ID: <input type="text" name="pid" size="28" required><br><br>
					Product Name: <input type="text" name="pname" size="25"	required><br><br>
					Product Quantity: <input title="Please input a number."	type="text" name="pqty" size="23" required><br><br>
					Supplier Price: <input title="Please input a number." type="text" name="price" size="25" required><br><br>
					
					<!-- Save button -->
					<input type="submit" value="Save" class="btn btn-success">
				</form>

			</div>
		</div>
	</div>

</body>
</html>