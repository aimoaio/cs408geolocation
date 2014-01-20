
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>

<%@page import="geolocation.PdfBoxGAEDemo"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
  <head>
    <meta charset="UTF-8" />
    <title>Geolocation and Google Maps API</title>
    <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script>
      function writeAddressName(latLng) {
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({
          "location": latLng
        },
        function(results, status) {
          if (status == google.maps.GeocoderStatus.OK){
            document.getElementById("address").innerHTML = results[0].formatted_address;
            var country;
            var postcode;
            var locality;
            var street;
            var state;

            for (i=0;i<results[0].address_components.length;i++){
                for (j=0;j<results[0].address_components[i].types.length;j++){
                   if(results[0].address_components[i].types[j]=="country")
    {
                      country = results[0].address_components[i].long_name
    ;
                    }
                    else if(results[0].address_components[i].types[j]=="postal_code"){
                      postcode = results[0].address_components[i].long_name;
                      }
                      else if(results[0].address_components[i].types[j]=="sublocality" || results[0].address_components[i].types[j]=="locality"){
                      locality = results[0].address_components[i].long_name;
                      }
                       else if(results[0].address_components[i].types[j]=="route"){
                    street = results[0].address_components[i].long_name;
                      } else if(results[0].address_components[i].types[j]=="administrative_area_level_1" || results[0].address_components[i].types[j]=="administrative_area_level_2"){
                    state = results[0].address_components[i].long_name;
                      }
                      
            }
            }
           
            document.getElementById("geocodeterms").innerHTML="Street: " + street.toString() +
            "<br>Town/City: " + locality.toString() +
            "<br>County/State: " + state.toString() +
            "<br> Country: " + country.toString() +
            "<br> Postcode: " + postcode.toString();
            document.getElementById("town").innerHTML= locality.toString();
          }
          else
            document.getElementById("error").innerHTML += "Unable to retrieve your address" + "<br />";
        });
      }
 
      function geolocationSuccess(position) {
        var userLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        // Write the formatted address
        writeAddressName(userLatLng);
 
        var myOptions = {
          zoom : 15,
          center : userLatLng,
          mapTypeId : google.maps.MapTypeId.ROADMAP
        };
        // Draw the map
        var mapObject = new google.maps.Map(document.getElementById("map"), myOptions);
        // Place the marker
        new google.maps.Marker({
          map: mapObject,
          position: userLatLng
        });

       
        
       // Draw a circle around the user position to have an idea of the current localization accuracy
        var circle = new google.maps.Circle({
          center: userLatLng,
          radius: position.coords.accuracy,
          map: mapObject,
          fillColor: '#0000FF',
          fillOpacity: 0.5,
          strokeColor: '#0000FF',
          strokeOpacity: 1.0
        });
        mapObject.fitBounds(circle.getBounds());
      }
 
      function geolocationError(positionError) {
        document.getElementById("error").innerHTML += "Error: " + positionError.message + "<br />";
      }
 
      function geolocateUser() {
        // If the browser supports the Geolocation API
        if (navigator.geolocation)
        {
          var positionOptions = {
            enableHighAccuracy: true,
            timeout: 10 * 1000 // 10 seconds
          };
          navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError, positionOptions);
        }
        else
          document.getElementById("error").innerHTML += "Your browser doesn't support the Geolocation API";
      }
 
      window.onload = geolocateUser;
    </script>
    <style type="text/css">
      #map {
        width: 500px;
        height: 500px;
      }
    </style>
  </head>
  <body>
    <h1>Basic example</h1>
    <div id="map"></div>
    <p><b>Address</b>: <span id="address"></span></p>
    <p><span id="geocodeterms"></span></p>
    <p><span id="town"></span></p>
    <p id="error"></p>
    <h2>PdfBox running on GAE - Demo</h2>



	
<%
	String pdfurl = request.getParameter("pdfurl");
	String x = request.getParameter("X");
	String y = request.getParameter("Y");
	String w = request.getParameter("W");
	String h = request.getParameter("H");
	String term = request.getParameter("term");

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
	Search term: <input type="text" name="term" value="<%=term%>"/> <br/>
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
			String tterm = term;
			ArrayList<String> pdfText = geolocation.PdfBoxGAEDemo.Exec(pdfurl, xx, yy, ww, hh, tterm);
			pdfText.toString();

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
