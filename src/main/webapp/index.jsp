<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Home Page</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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

	<header>
		<h1>Stock Management System</h1>
	</header>

	<!-- Navigation buttons -->
	<nav>
		<a href="http://localhost:8090/StockManagementSystem/index.jsp" class="btn btn-success">Home</a>
		<a href="http://localhost:8090/StockManagementSystem/ProductServlet/dashboard" class="btn btn-success">Product Management</a>
		<a href="http://localhost:8090/StockManagementSystem/UserServlet/dashboard" class="btn btn-success">User Management</a>
		<a href="http://localhost:8090/StockManagementSystem/Logout.jsp" class="btn btn-success">Logout</a>
	</nav>

	<div class="container">
		<!-- Greeting Message -->
		<h1>Welcome User</h1>

		<!-- HTML element required for updateDateTime function to display current date and time -->
		<p id="datetime"></p>

	</div>
	
	<!-- Page Footer to include the copyright icon  and User's Company Name -->
	<footer>
		<p>&copy; 2024 User's Company Name</p>
	</footer>

<script>
	<!-- Function to display current date and time -->
    function updateDateTime() {
    const currentDate = new Date();
    const dateTimeString = currentDate.toLocaleString();
    document.getElementById("datetime").textContent = dateTimeString;
    }

    <!-- Call function to update the current date and time on home page -->
    updateDateTime();
    
    <!-- To update the time every 1000 miliseconds (every 1 sec) -->
    setInterval(updateDateTime, 1000);
</script>

</body>
</html>
