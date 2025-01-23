<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Management</title>

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

.barcode-img {
    max-width: 200px;
    height: auto;
}

.btn-custom {
    margin-top: 5px;
}

#searchInput {
    margin-bottom: 20px;
    width: 300px;
    padding: 8px;
    font-size: 1em;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.notification {
    color: red;
    font-weight: bold;
}
</style>
</head>

<body>

<div class="row">
    <div class="container">
        <h3 class="text-center">Product Management</h3>
        <hr>

        <!-- Home and Add New Product Buttons -->
        <div class="text-left">
            <a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-success">Home</a>
            <a href="<%=request.getContextPath()%>/productAdd.jsp" class="btn btn-success">Add New Product</a>
        </div>

        <!-- Quick Search Bar (PID results only) -->
        <input type="text" id="searchInput" placeholder="Enter Product ID or Scan Barcode..." onkeyup="searchPid()">

        <!-- Product List Table -->
        <table class="table table-bordered mt-4" id="productList">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Product Quantity</th>
                    <th>Supplier Price</th>
                    <th>Product ID Barcode</th>
                    <th>Print Barcode</th>
                    <th>Stock Level</th>
                    <th>Restock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Populate Product Details for each Product from the Productdetails database to the Product List -->
                <c:forEach var="product" items="${listProducts}">
                <tr>
                    <td><c:out value="${product.pid}" /></td>
                    <td><c:out value="${product.pname}" /></td>
                    <td><c:out value="${product.pqty}" /></td>
                    <td><c:out value="${product.price}" /></td>

                    <!-- Generates Product ID Barcode image, with Product Name above and Product ID below of barcode -->
                    <td>
                        <div>
                            <strong>${product.pname}</strong>
                        </div>
                        <img src="${pageContext.request.contextPath}/BarcodeServlet?pid=${product.pid}" alt="Barcode for ${product.pid}" id="barcode-${product.pid}" class="barcode-img" />
                    </td>

                    <!-- Print Product ID Barcode image button -->
                    <td><br><br>
                        <button class="btn btn-success btn-custom" onclick="printBarcode('${product.pid}', '${product.pname}')">Print</button>
                    </td>

                    <!-- Auto Notification Checkbox for Low Quantity -->
                    <td><br><br>
                        <input type="checkbox" id="notify-${product.pid}" data-pqty="${product.pqty}" onchange="autoCheckLowStock('${product.pid}', ${product.pqty})">
                        <span class="notification" id="notification-${product.pid}" style="display:none;">Low Stock</span>
                    </td>

                    
                    <td><br>
                        <!-- Email Button for Ordering New Stock (Only appears when stock is low <10 pqty) -->
                        <button class="btn btn-warning btn-custom" id="emailButton-${product.pid}" style="display:none;" onclick="createSupplierEmail('${product.pname}', '${product.pid}', '${product.pqty}')">Create Restock Order</button>
                    </td>

                    <!-- Edit and Delete (with confirmation popup window) Product Buttons (using Product ID) -->
                    <td><br>
                        <a href="edit?pid=<c:out value='${product.pid}' />" class="btn btn-success">Edit</a><br><br>
                        <a href="delete?pid=<c:out value='${product.pid}' />" class="btn btn-success" onclick="return confirm('Confirm product deletion?')">Delete</a>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>

<!-- Quick Search Function to filter Product List Table on Product Management page (via PID only) -->
function searchPid() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("productList");
    tr = table.getElementsByTagName("tr");

    <!-- Loops through each row in the Product List table and hide records that does not match the search query -->
    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}


<!-- Function to generate a print preview of the Product ID barcode image in a new window -->
function printBarcode(pid, pname) {
    var barcodeImage = document.getElementById('barcode-' + pid);

    if (barcodeImage) {
        var printWindow = window.open('', '_blank');
        printWindow.document.write('<html><head><title>Print Barcode</title></head><body>');
        printWindow.document.write('<div style="text-align: center; font-size: 16px; font-weight: bold;">' + pname + '</div>');
        printWindow.document.write('<img src="' + barcodeImage.src + '" style="display:block; margin: 0 auto; max-width: 100%;" />');
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        printWindow.print();
        printWindow.onafterprint = function() {
        printWindow.close();
        };
    }
}


<!-- Function to automatically check the low stock checkboxes (for pqty <10) whenever page is refreshed -->
function autoCheckLowStock() {
	
	<!-- set threshold pqty to trigger as low stock then look through all rows in Product List Table -->
    var threshold = 9;
    var products = document.querySelectorAll('tr');
    
    <!-- loops through the Product List Table rows to look for the relevant data below -->
    products.forEach(function(row) {
        var pidCell = row.cells[0];
        var pqtyCell = row.cells[2];
        var notifyCheckbox = row.querySelector('input[type="checkbox"]');
        var notificationElement = row.querySelector('.notification');
        var emailButton = row.querySelector('.btn-warning');

        if (pqtyCell && notifyCheckbox && notificationElement) {
        	<!-- Checks for pqty from row -->
        	var pqty = parseInt(pqtyCell.textContent || pqtyCell.innerText);
        	<!-- Checks for low stock -->
        	if (pqty <= threshold) {
        		<!-- Low Stock alert to appear only if lowstock checkbox is checked -->
                notifyCheckbox.checked = true;
                notificationElement.style.display = 'inline';
                <!-- Restock Order Button to appear only if stock is low -->
                if (emailButton) {
                    emailButton.style.display = 'inline';
                }
            }
        }
    });
}

<!-- Automatically call the autoCheckLowStock function whenever page is loaded -->
window.onload = function() {
    autoCheckLowStock();
};


<!-- Function to create the email and open it in a new window using the mailto: link -->
function createSupplierEmail(pname, pid) {
	
	<!-- Create new email subject and body with predefined message -->
    var emailSubject = "Restock for " + pname;
    var emailBody = "Dear Supplier,\n\nWe are currently low on stock for '" + pname + "' (Product ID: " + pid + "). We would like to restock the same quantity as our previous order.\n\n\nThank you,\nUser's Company Name";

    <!-- Encode email subject and body to mailto link -->
    var encodedSubject = encodeURIComponent(emailSubject);
    var encodedBody = encodeURIComponent(emailBody);

    <!-- Create the mailto URL with (dummy) supplier email and encoded email subject and body -->
    var mailtoLink = "mailto:supplier@example.com?subject=" + encodedSubject + "&body=" + encodedBody;

    <!-- Opens the mailto link in a new browser window -->
    window.open(mailtoLink, '_blank');
}

</script>

</body>
</html>
