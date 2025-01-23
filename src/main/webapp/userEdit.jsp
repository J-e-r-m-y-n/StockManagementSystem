<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Edit</title>

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

	<nav class="navbar navbar-expand-md navbar-light">
		<br>
		<ul class="navbar-nav">
			<li><a
				href="<%=request.getContextPath()%>/UserServlet/dashboard"
				class="btn btn-success">Back to User Management
			</a></li>
		</ul>
	</nav>

	<div class="container col-md-6">
		<div class="card">
			<div class="card-body">

				<!-- Condition - if user name is not empty, then update user -->
				<c:if test="${!empty user.name}">
					<form action="update" method="post">
				</c:if>
				<!-- Condition - if user name is empty, then create new user -->
				<c:if test="${empty user.name}">
					<form action="insert" method="post">
				</c:if>

				<caption>
					<h2>
						<!-- Condition - if user name is not empty, then new form's header will be "Edit User" -->
						<c:if test="${!empty user.name}">Edit User</c:if>
						<!-- Condition - if user name is empty, then new form's header will be "Add New User" -->
						<c:if test="${empty user.name}">Add New User</c:if>
					</h2>
				</caption>
				<br>
				<!-- Condition - if user name is not equal to null value, then copy value from existing user name to original name (as a hidden field) -->
				<c:if test="${user != null}">
					<input type="hidden" name="oriName" value="<c:out
					value='${user.name}' />" />
				</c:if>
				
				<!-- Form fields for User Edit/Add Form -->
				<fieldset class="form-group">
					<label>User Name:</label> <input type="text" value="<c:out
					value='${user.name}' />" class="form-control" name="userName" required="required">
				</fieldset>

				<fieldset class="form-group">
					<label>Password:</label> <input type="text" value="<c:out
					value='${user.password}' />" class="form-control" name="password">
				</fieldset>

				<fieldset class="form-group">
					<label>User Email:</label> <input type="text" value="<c:out
					value='${user.email}' />" class="form-control" name="email">
				</fieldset>

				<fieldset class="form-group">
					<label>Language:</label> <input type="text" value="<c:out
					value='${user.language}' />" class="form-control" name="language">
				</fieldset>
				
				<!-- Save Button -->
				<button type="submit" class="btn btn-success">Save</button>
				</form>
			</div>
		</div>
	</div>

</body>
</html>