 			var map;
            var initialLocation = new google.maps.LatLng(-44.6895642,169.1320571); //2
            function init() {
                var duckOptions = { //3
                    zoom: 12,
                    center: initialLocation,
                    mapTypeId: google.maps.MapTypeId.HYBRID
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), duckOptions); //4
                var marker = new google.maps.Marker({ //5
                    position: initialLocation, 
                    map: map
                });
            }