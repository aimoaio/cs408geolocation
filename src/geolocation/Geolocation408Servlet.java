package geolocation;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.*;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;

@SuppressWarnings("serial")
public class Geolocation408Servlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
		PDDocument document;
		try {
			PDFTextStripper stripper;
			resp.getWriter().println("Now printing stuff....1");
			String city = req.getHeader("X-AppEngine-City");
			resp.getWriter().println("Dat city: " + city);
//			ServletContext context = getServletContext();
//			InputStream is = context.getResourceAsStream("/WEB-INF/firstbustimetable.pdf");
//			document = PDDocument.load(is);
//			resp.getWriter().println("Now printing stuff....2");
//			stripper = new PDFTextStripper();
//			stripper.setSortByPosition( true );
//			System.out.println(stripper.getText(document));
//			resp.getWriter().println("Now printing stuff....3");
			//resp.getWriter().println(stripper.getText(document));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
