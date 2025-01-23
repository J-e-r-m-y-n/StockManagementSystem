// Library for Google ZXing barcode
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;

// Library for Java Abstract Window Toolkit
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/BarcodeServlet")
public class BarcodeServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// Get Product ID from the request
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		String pid = request.getParameter("pid");

		// If Product ID is missing then return error message "Product ID required"
		if (pid == null || pid.isEmpty()) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID required");
			return;
		}

		// Set response type as .png format to display as image
		response.setContentType("image/png");
		
		// Set Barcode size settings (in pixels)
		try {
			
			// Width of the barcode
			int width = 300;

			// Height of the barcode
			int height = 150;

			// Margin for the barcode
			int margin = 10;

			// Generate Product ID barcode
			MultiFormatWriter writer = new MultiFormatWriter();
			Map<EncodeHintType, Object> hints = new HashMap<>();

			// Set barcode margin then format to Code128 with the configured barcode size settings
			hints.put(EncodeHintType.MARGIN, margin);
			BitMatrix bitMatrix = writer.encode(pid, BarcodeFormat.CODE_128, width, height, hints);
			BufferedImage barcodeImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

			// Increase image size to include both the barcode and the Product ID text
			int textHeight = 40;
			BufferedImage finalImage = new BufferedImage(width, height + textHeight, BufferedImage.TYPE_INT_ARGB);

			// Create a Graphics2D object to draw both the barcode and the text
			Graphics2D graphics = finalImage.createGraphics();
			graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

			// Draw the barcode on the final image
			graphics.drawImage(barcodeImage, 0, 0, null);

			// Set the font and color for the Product ID text
			Font font = new Font("Tahoma", Font.PLAIN, 20);
			graphics.setFont(font);
			graphics.setColor(Color.BLUE);

			// Draw the Product ID value as text under the barcode
			int textWidth = graphics.getFontMetrics().stringWidth(pid);
			graphics.drawString(pid, (width - textWidth) / 2, height + (textHeight / 2));

			// Dispose of the graphics object to release resources
			graphics.dispose();

			// Write the final image (barcode + text) to the response output stream
			javax.imageio.ImageIO.write(finalImage, "PNG", response.getOutputStream());

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating barcode");
		}
	}
}
