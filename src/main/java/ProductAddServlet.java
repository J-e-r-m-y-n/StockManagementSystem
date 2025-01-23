
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//Import these libraries from java.io and java.sql
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/ProductAddServlet")
public class ProductAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductAddServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");

		// Step 1: Initialize a PrintWriter object to return the html values via the response
		PrintWriter out = response.getWriter();

		// Step 2: retrieve the four parameters from the request from the web form
		String n = request.getParameter("pid");
		String p = request.getParameter("pname");
		String e = request.getParameter("pqty");
		String c = request.getParameter("price");

		// Step 3: attempt connection to database using JDBC, you can change the username and password accordingly using the phpMyAdmin > User Account dashboard
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/productdetails", "root", "password");

		// Step 4: implement the sql query using prepared statement (https://docs.oracle.com/javase/tutorial/jdbc/basics/prepared.html)
		PreparedStatement ps = con.prepareStatement("INSERT INTO ProductDetails values(?,?,?,?)");

		// Step 5: parse in the data retrieved from the web form request into the prepared statement accordingly
		ps.setString(1, n);
		ps.setString(2, p);
		ps.setString(3, e);
		ps.setString(4, c);

		// Step 6: perform the query on the database using the prepared statement
		int i = ps.executeUpdate();

		// Step 7: check if the query had been successfully execute, return “New product added” via the response,
		if (i > 0) {
			out.println("<h1><br>New product added.</h1>");
		} else {
			out.println("<h1>Failed to add new product.</h1>");
		}
		} catch (Exception x) {
			x.printStackTrace();
			out.println("<h1>Error: " + x.getMessage() + "</h1>");
		}
	
		// Step 8: Buttons to either add new product or go back to productManagement.jsp
		out.println(
				"<button onclick='window.location.href=\"http://localhost:8090/StockManagementSystem/productAdd.jsp\"'>Add another Product</button>");
		out.println("<br><br>");
		out.println(
				"<button onclick='window.location.href=\"http://localhost:8090/StockManagementSystem/ProductServlet/dashboard\"'>Back to Product Management</button>");
	
		doGet(request, response);
	}

}
