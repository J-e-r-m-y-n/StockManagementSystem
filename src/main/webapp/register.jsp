<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>

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
	text-align: left;
	border-bottom: 1px solid #ddd;
}

header h1 {
	margin: 0;
	font-size: 2em;
	color: #333;
}

nav {
	display: flex;
	justify-content: left;
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
	text-align: left;
}

footer {
	background-color: #f8f8f8;
	text-align: left;
	padding: 10px;
	border-top: 1px solid #ddd;
	position: fixed;
	width: 100%;
	bottom: 0;
}
</style>

</head>
<body>

	<div class="container col-md-6">
		<div class="card">
			<div class="card-body">
	
	<h1>User Registration</h1>
	<br>
	<!-- Form fields for new user registration -->
	<form action="RegisterServlet" method="Post">
		Name: <input type="text" name="userName" size="25" required><br><br>
		Password: <input type="password" name="password" size="22"	pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{10,12}" title="Password must contain at least one number (0-9) and one Uppercase and lowercase letter, and at least 10 (min) to 12 (max) characters" required><br><br>
		Email: <input type="email" name="email" size="25" required><br><br>
		Language: <select name="language"> <option>English</option>	<option>Chinese</option> </select><br><br>
		
		<!-- Submit Button -->
		<input type="submit" value="Submit" class="btn btn-success">
	</form>

			</div>
		</div>
	</div>

</body>
</html>