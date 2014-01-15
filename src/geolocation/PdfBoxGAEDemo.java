package geolocation;



import it.fhtino.pdfbox.alt.Rectangle;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Logger;

import org.pdfbox.io.RandomAccessBuffer;
import org.pdfbox.pdmodel.PDDocument;
import org.pdfbox.pdmodel.PDPage;
import org.pdfbox.util.PDFTextStripperByAreaGAE;

public class PdfBoxGAEDemo {

	private static final Logger log = Logger.getLogger(PdfBoxGAEDemo.class.getName());

	public static String Exec(String pdfUrl, float x, float y, float w, float h) {

		log.info("PdfUrl=" + pdfUrl);

		try {
			URL urlObj = new URL(pdfUrl);
			HttpURLConnection connection = (HttpURLConnection) urlObj.openConnection();
			connection.addRequestProperty("Cache-Control", "no-cache,max-age=0");
			connection.addRequestProperty("Pragma", "no-cache");
			connection.setInstanceFollowRedirects(false);
			int httpRespCode = connection.getResponseCode();

			if (httpRespCode == 200) {
				RandomAccessBuffer tempMemBuffer = new RandomAccessBuffer();
				PDDocument doc = PDDocument.load(connection.getInputStream(), tempMemBuffer);

				PDFTextStripperByAreaGAE sa = new PDFTextStripperByAreaGAE();
				sa.addRegion("Area1", new Rectangle(x, y, w, h));
				PDPage p = (PDPage) doc.getDocumentCatalog().getAllPages().get(0);
				sa.extractRegions(p);
				
				String text = sa.getTextForRegion("Area1");
				System.out.println(text);
				text = text.replace("Hamilton", "HEHEHEHE");
				return text;

			} else
				throw new Exception("Http return code <> 200. Received: " + httpRespCode);

		} catch (Exception e) {
			log.severe("EXCEPTION: " + e.toString());
			return "*** EXCEPTION *** " + e.toString();
		}
	}
}
