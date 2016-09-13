$( document ).ready(function() {

  $( "#give_location_button" ).click(function() {
    request_geo_location();
  });

});

function request_geo_location(){
  var startPos;
  var geoSuccess = function(position) {
    startPos = position;
    document.getElementById('lat_field').value = startPos.coords.latitude;
    document.getElementById('lng_field').value = startPos.coords.longitude;
    document.getElementById("new_check_in").submit();
  };
  navigator.geolocation.getCurrentPosition(geoSuccess);
}
