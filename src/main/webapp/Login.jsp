<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Login Page</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="shortcut icon" href="#">

</head>

<body>
	
	<br>
	<h1>User Login</h1>
	<br>

	<!-- Form fields for User to fill in for login -->
	<form action="LoginServlet" method="post">
		Enter your Username: <input type="text" name="uname" size="20" required><br><br>
		Enter your Password: <input	type="password" name="pass" size="20" required><br><br>

	<!-- Submit Button -->
	<input type="submit" value="Login" class="btn btn-success" />
	</form>
	
</body>
</html>