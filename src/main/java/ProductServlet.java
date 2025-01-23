
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Step 1: Prepare list of variables used for database connections
	private String jdbcURL = "jdbc:mysql://localhost:3306/productdetails";
	private String jdbcUsername = "root";
	private String jdbcPassword = "password";

	// Step 2: Prepare list of SQL prepared statements to perform CRUD to our database
	private static final String INSERT_PRODUCTS_SQL = "INSERT INTO ProductDetails"
			+ " (pid, pname, pqty, price) VALUES " + " (?, ?, ?, ?);";
	private static final String SELECT_PRODUCT_BY_ID = "SELECT pid,pname,pqty,price FROM ProductDetails WHERE pid =?";
	private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM ProductDetails ";
	private static final String DELETE_PRODUCTS_SQL = "DELETE FROM ProductDetails WHERE pid = ?;";
	private static final String UPDATE_PRODUCTS_SQL = "UPDATE ProductDetails SET pid = ?,pname= ?,pqty =?,price =? where pid = ?;";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductServlet() {
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

		// Step 3: Depending on the request servlet path, determine the function to invoke using the follow switch statement.
		String action = request.getServletPath();
		try {
			switch (action) {
			case "/ProductServlet/delete":
				deleteProduct(request, response);
				break;
			case "/ProductServlet/edit":
				showEditProductForm(request, response);
				break;
			case "/ProductServlet/update":
				updateProduct(request, response);
				break;
			case "/ProductServlet/dashboard":
				listProducts(request, response);
				break;
			case "/ProductServlet/insert":
				addNewProduct(request, response);
				break;
			}
		} catch (SQLException ex) {
			throw new ServletException(ex);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	// Step 4: Implement the getConnection method which facilitates connection to the database via JDBC
	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return connection;
	}

	// Step 5: LISTPRODUCTS function to connect to the database and retrieve all products records
	private void listProducts(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, IOException, ServletException {
		List<Product> products = new ArrayList<>();
		try (Connection connection = getConnection();

		// Step 5.1: Create a statement using connection object
		PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCTS);) {

		// Step 5.2: Execute the query or update query
		ResultSet rs = preparedStatement.executeQuery();
	
		// Step 5.3: Process the ResultSet object.
		while (rs.next()) {
			String pid = rs.getString("pid");
			String pname = rs.getString("pname");
			String pqty = rs.getString("pqty");
			String price = rs.getString("price");
			products.add(new Product(pid, pname, pqty, price));
			}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}

		// Step 5.4: Set the products list into the listProducts attribute to be pass to the productManagement.jsp
		request.setAttribute("listProducts", products);
		request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
		}

	// method to get parameter, query database for existing product data and redirect to product EDIT page
	private void showEditProductForm(HttpServletRequest request, HttpServletResponse response)
	throws SQLException, ServletException, IOException {

	// get parameter passed in the URL
	String pid = request.getParameter("pid");
	Product existingProduct = new Product("", "", "", "");

	// Step 1: Establishing a Connection
	try (Connection connection = getConnection();

	// Step 2:Create a statement using connection object
	PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID);) {
	preparedStatement.setString(1, pid);

	// Step 3: Execute the query or update query
	ResultSet rs = preparedStatement.executeQuery();

	// Step 4: Process the ResultSet object
	while (rs.next()) {
		pid = rs.getString("pid");
		String pname = rs.getString("pname");
		String pqty = rs.getString("pqty");
		String price = rs.getString("price");
		existingProduct = new Product(pid, pname, pqty, price);
		}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

	// Step 5: Set existingProduct to request and serve up the productEdit form
	request.setAttribute("Product", existingProduct);
	request.getRequestDispatcher("/productEdit.jsp").forward(request, response);
	}

	// method to UPDATE the product table base on the form data
	private void updateProduct(HttpServletRequest request, HttpServletResponse response)
	throws SQLException, IOException {

	// Step 1: Retrieve value from the request
	String oriPid = request.getParameter("oriPid");
	String pid = request.getParameter("pid");
	String pname = request.getParameter("pname");
	String pqty = request.getParameter("pqty");
	String price = request.getParameter("price");

	// Step 2: Attempt connection with database and execute update product SQL query
	try (Connection connection = getConnection();
		PreparedStatement statement = connection.prepareStatement(UPDATE_PRODUCTS_SQL);) {
		statement.setString(1, pid);
		statement.setString(2, pname);
		statement.setString(3, pqty);
		statement.setString(4, price);
		statement.setString(5, oriPid);
		int i = statement.executeUpdate();
	}

	// Step 3: redirect back to ProductServlet (note: remember to change the url to your project name)
	response.sendRedirect("http://localhost:8090/StockManagementSystem/ProductServlet/dashboard");
	}

	// method to DELETE product
	private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
	throws SQLException, IOException {

	// Step 1: Retrieve value from the request
	String pid = request.getParameter("pid");

	// Step 2: Attempt connection with database and execute delete product SQL query
	try (Connection connection = getConnection();
		PreparedStatement statement = connection.prepareStatement(DELETE_PRODUCTS_SQL);) {
		statement.setString(1, pid);
		int i = statement.executeUpdate();
	}

	// Step 3: redirect back to ProductServlet dashboard (note: remember to change the url to your project name)
	response.sendRedirect("http://localhost:8090/StockManagementSystem/ProductServlet/dashboard");
	}

	// method to trigger ProductAddServlet
	private void addNewProduct(HttpServletRequest request, HttpServletResponse response)
	throws SQLException, IOException, ServletException {
	RequestDispatcher rd = null;
	rd = getServletContext().getRequestDispatcher("/ProductAddServlet");
	rd.include(request, response);
	}

}
