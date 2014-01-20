package geolocation;



import it.fhtino.pdfbox.alt.Rectangle;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.pdfbox.io.RandomAccessBuffer;
import org.pdfbox.pdmodel.PDDocument;
import org.pdfbox.pdmodel.PDDocumentCatalog;
import org.pdfbox.pdmodel.PDPage;
import org.pdfbox.util.PDFTextStripperByAreaGAE;

public class PdfBoxGAEDemo {

	private static final Logger log = Logger.getLogger(PdfBoxGAEDemo.class.getName());
	
	static ArrayList<String> text;
	static String s;

	public static ArrayList<String> Exec(String pdfUrl, int x, int y, int w, int h, String term) {

		log.info("PdfUrl=" + pdfUrl);
		System.out.println("didnt get into try");
		text = new ArrayList<String>();

		try {
			URL urlObj = new URL(pdfUrl);
			HttpURLConnection connection = (HttpURLConnection) urlObj.openConnection();
			connection.addRequestProperty("Cache-Control", "no-cache,max-age=0");
			connection.addRequestProperty("Pragma", "no-cache");
			connection.setInstanceFollowRedirects(false);
			int httpRespCode = connection.getResponseCode();
			System.out.println("just before the if");

			if (httpRespCode == 200) {
				RandomAccessBuffer tempMemBuffer = new RandomAccessBuffer();
				PDDocument doc = PDDocument.load(connection.getInputStream(), tempMemBuffer);
				System.out.println("line1");

				PDFTextStripperByAreaGAE sa = new PDFTextStripperByAreaGAE();
				System.out.println("line 1.1");
				sa.addRegion("Area1", new Rectangle(x, y, w, h));
				System.out.println("line 1.2");
				//PDPage p = (PDPage) doc.getDocumentCatalog().getAllPages().get(0); //this line is the problem
				PDDocumentCatalog cat = doc.getDocumentCatalog();
				System.out.println("line 1.3");
				//System.out.println(cat.toString());
				List <PDPage> pages = cat.getAllPages();
				System.out.println("term: " + term);
				System.out.println("line 1.4");
				for (int i=0;i<4; i++){
					PDPage p = pages.get(i);
					sa.extractRegions(p);
					s = sa.getTextForRegion("Area1");
					if(term!=null){
						String newterm = "<span style='background-color:yellow;'>" + term + "</span>";
						s = s.replace(term, newterm);
						text.add(s);
						}
				}
				
				//System.out.println("line 1.5");
				//System.out.println("line2");
				//text = sa.getTextForRegion("Area1");
				//System.out.println(text);
				return text;
				

			} else{
				System.out.println("didnt get into if");
				throw new Exception("Http return code <> 200. Received: " + httpRespCode);
			}

		} catch (Exception e) {
			log.severe("EXCEPTION: " + e.toString());
			//return "*** EXCEPTION *** " + e.toString();
		}
		return text;
	}
}
