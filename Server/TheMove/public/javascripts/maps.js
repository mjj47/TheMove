var map;

function setup() {
	// initialize();
	// doDrawing();
	heatMap();
}

function initialize() {
	console.log("initialize");
	var mapOptions = {
	  center: { lat: -34.397, lng: 150.644},
	  zoom: 20
	};
	map = new google.maps.Map(document.getElementById('map-canvas'),
	    mapOptions);
}

function heatMap() {
	var heatmapData = [];
	var elems = document.querySelectorAll(".datumn");
	var lat = 0.0;
	var lon = 0.0;
	for (var i = elems.length - 1; i >= 0; i--) {
		var el = elems[i].innerHTML;
		var points = el.split(" ");
		lat += parseFloat(points[2]);
		lon += parseFloat(points[1]);
		var point = new google.maps.LatLng(parseFloat(points[2]), parseFloat(points[1]));
		heatmapData.push(point)
		console.log(point);
	};
	lat /= elems.length;
	lon /= elems.length;
	
	console.log(lat);
	console.log(lon);
var sanFrancisco = new google.maps.LatLng(lat, lon);

map = new google.maps.Map(document.getElementById('map-canvas'), {
  center: sanFrancisco,
  zoom: 13,
  mapTypeId: google.maps.MapTypeId.SATELLITE
});


var heatmap = new google.maps.visualization.HeatmapLayer({
  data: heatmapData
});
heatmap.setMap(map);
}

// function doDrawing() {
// 	var drawingManager = new google.maps.drawing.DrawingManager();
// 	drawingManager.setMap(map);
// }

google.maps.event.addDomListener(window, 'load', setup);


