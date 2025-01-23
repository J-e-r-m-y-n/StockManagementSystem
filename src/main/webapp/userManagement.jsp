<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Management</title>

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

	<div class="row">
		<div class="container">
			<h3 class="text-center">User Management</h3>
			<hr>
			<div class="container text-left">
				<!-- Home button redirects to the index.jsp home page -->
				<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-success">Home</a>

				<!-- Add New User button redirects to the register.jsp page -->
				<a href="<%=request.getContextPath()%>/register.jsp" class="btn btn-success">Add New User</a>
			</div>
			<br>
			
			<!-- User List Table -->
			<table class="table">
				<thead>
					<tr>
						<th>Name</th>
						<th>Password</th>
						<th>Email</th>
						<th>Language</th>
						<th>Actions</th>
					</tr>
				</thead>
				
				<!-- Pass in the list of users receive via the Servlet response to a loop -->
				<tbody>
					<c:forEach var="user" items="${listUsers}">
					
						<!-- For each user in the database, display their information accordingly -->
						<tr>
							<td><c:out value="${user.name}" /></td>
							<td><c:out value="${user.password}" /></td>
							<td><c:out value="${user.email}" /></td>
							<td><c:out value="${user.language}" /></td>
							
							<!-- For each user in the database, Edit/Delete buttons which invokes the edit/delete functions -->
							<td><a href="edit?name=<c:out value='${user.name}' />" class="btn btn-success">Edit</a> &nbsp;&nbsp;&nbsp;&nbsp;
							<a href="delete?name=<c:out value='${user.name}' />" class="btn btn-success" onclick="return confirm('Confirm user deletion?')">Delete</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>