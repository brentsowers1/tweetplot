var map;
var markers;

function loadMap(center_lat, center_lon) {
    var latlng = new google.maps.LatLng(center_lat, center_lon);
    var myOptions = {
      zoom: 8,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);
    doRequest(false);
    new PeriodicalExecuter(doUpdate, 30);
    markers = [];
}

function doRequest(checkBounds) {
//    if (checkBounds) {
//        var bounds = map.getBounds();
//    } else {
//        var bounds = {};
//    }
//    for (i in markers) {
//        markers[i].setMap(null);
//    }
    new Ajax.Request('/searches/' + searchId + '/tweets', {
        method: 'post',
        //parameters: {"bounds": bounds},
        onSuccess: function(transport) {
            var tweets = transport.responseJSON;
            for(var i=0; i < tweets.length; i++) {
                var tweet = tweets[i].search_tweet;
                if (tweet.location) {
                    addMarker(tweet.location.y, tweet.location.x, tweet.author_pic, tweet.author_name, tweet.text, tweet.timestamp);
                }
            }
        }
    })
}

function doUpdate() {
    var bounds = map.getBounds();
    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();
    new Ajax.Request('/searches/' + searchId + '/do_search', {
        method: 'post',
        parameters: {"neLat": ne.lat(), "neLng": ne.lng(), "swLat": sw.lat(), "swLng" : sw.lng()},
        onSuccess: function(transport) {
            var tweets = transport.responseJSON;
            for(var i=0; i < tweets.length; i++) {
                var tweet = tweets[i].search_tweet;
                if (tweet.location) {
                    addMarker(tweet.location.y, tweet.location.x, tweet.author_pic, tweet.author_name, tweet.text, tweet.timestamp);
                }
            }
        }
    })
}

function addMarker(lat, lng, icon, author, text, timestamp) {
    var dateObj = new Date(timestamp);
    var dateStr = dateObj.toLocaleString();
    var latLng = new google.maps.LatLng(lat, lng);
    var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        icon: icon,
        title: dateStr + " " + author
    });
    markers[markers.length] = marker;

    var contentString = dateStr + ":@" + author + ": " + text;
    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
    });



}




