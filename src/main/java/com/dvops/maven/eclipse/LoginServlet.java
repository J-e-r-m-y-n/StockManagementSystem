package com.dvops.maven.eclipse;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

//Import PrintWriter class from Java.io lib
import java.io.PrintWriter;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Set parameters to get username and password as provided by user.
		String username = request.getParameter("uname");
		String password = request.getParameter("pass");

		// Credentials to login to SQL database.
		String dbURL = "jdbc:mysql://localhost:3306/userdetails";
		String dbUsername = "root";
		String dbPassword = "password";

		// Check SQL database for matching username and password.
		String query = "SELECT * FROM userdetails WHERE name = ? AND password = ?";

		try {
			// Step 1: Load and register MySQL JDBC driver.
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Connect to database using provided SQL database credentials.
			Connection conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

			// Step 3: Set SQL PreparedStatement to query for matching username and
			// password.
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, username);
			stmt.setString(2, password);

			ResultSet rs = stmt.executeQuery();

			// Step 4: Search for user in database.
			if (rs.next()) {
				// If username and password matched, redirect to the home page.
				response.sendRedirect("index.jsp");
			} else {
				// If username and password cannot be found, print error message and provide
				// link back to Login Page.
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("<h2>You have entered an invalid username or password.</h2>");
				out.println("<a href=\"http://localhost:8090/StockManagementSystem/Login.jsp\">Back to Login Page</a>");
			}
		} catch (Exception e) {
			// If login process encounters error, print error message and provide link back
			// to Login Page.
			e.printStackTrace();
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<h2>An error has occurred during login process</h2>");
			out.println("<a href=\"http://localhost:8090/StockManagementSystem/Login.jsp\">Back to Login Page</a>");
		}
	}
}