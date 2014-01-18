<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@page import="geolocation.PdfBoxGAEDemo"%>
<%@page import="java.util.Date"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PdfBox running on GAE - Demo</title>

<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="/js/map.js"></script>
  
</head>
 <body onload="init()"> 
        <h1>Mapping Stuff</h1>
        <div id="map_canvas" style="width:100%;height:800px"></div> 
<!-- <body style="font-family: Verdana; font-size: 12px;"> -->
<h2>PdfBox running on GAE - Demo</h2>

<div>

	
<%
	String pdfurl = request.getParameter("pdfurl");
	String x = request.getParameter("X");
	String y = request.getParameter("Y");
	String w = request.getParameter("W");
	String h = request.getParameter("H");

	if (pdfurl == null)
		pdfurl = "";
	if (x == null)
		x = "0";
	if (y == null)
		y = "0";
	if (w == null)
		w = "500";
	if (h == null)
		h = "800";

	String captchaError = "";
	
	
	

// 	if (request.getParameter("btnSumbit") != null) {
// 		String recaptcha_challenge_field = request.getParameter("recaptcha_challenge_field");
// 		String recaptcha_response_field = request.getParameter("recaptcha_response_field");
// 		String remoteip = request.getRemoteAddr();
// 		ReCaptcha rcap = new ReCaptcha("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
// 		if (!rcap.check(recaptcha_challenge_field, recaptcha_response_field, remoteip)) {
// 			captchaError = rcap.get_errorCode();
// 		}
// 	}
%>
<br />
<div style="background: #FFFFBB; display: inline-block; padding: 10px;">
<form method="post">Pdf url: <input type="text" name="pdfurl"
	value="<%=pdfurl%>" style="width: 400px;" /><br />
Area (pdf units) - X:<input type="text" name="X" value="<%=x%>"
	style="width: 50px;" /> Y:<input type="text" name="Y" value="<%=y%>"
	style="width: 50px;" /> W:<input type="text" name="W" value="<%=w%>"
	style="width: 50px;" /> H:<input type="text" name="H" value="<%=h%>"
	style="width: 50px;" /> <br />
<br />
<script type="text/javascript"
	src="http://api.recaptcha.net/challenge?k=6Lfn2AoAAAAAAGmBLQvWJIh7usoIJFV37BsALStI&error=<%=captchaError%>"></script><br />

<input type="submit" name="btnSumbit" value="Get text!" /></form>
</div>
<br />
<%
	if (request.getParameter("btnSumbit") != null) {
		if (captchaError.equals("")) {

			Date startDate = new Date();
			int xx = Integer.parseInt(x);
			int yy = Integer.parseInt(y);
			int ww = Integer.parseInt(w);
			int hh = Integer.parseInt(h);
			String text = "hehe";
			String pdfText = geolocation.PdfBoxGAEDemo.Exec(pdfurl, xx, yy, ww,hh, text);
			

			Date endDate = new Date();
			double deltaSeconds = (endDate.getTime() - startDate.getTime()) / 1000.0;
%><br />
<br />
Time (Http GET + text extraction):
<%=deltaSeconds%>
s
<br />
<br />
Extracted text:
<div style="background: #e0e0e0;"><pre><%=pdfText%></pre></div>
<%
	}
	}
%>

<br />
<br />
<a href="http://code.google.com/appengine/" target="_blank"> <img
	src="http://code.google.com/appengine/images/appengine-noborder-120x30.gif"
	alt="Powered by Google App Engine" border="0" /> </a>
<jsp:include page="/ga_include.html"></jsp:include>
</body>
</html>