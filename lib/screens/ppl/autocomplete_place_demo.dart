import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class AutoCompleteDemo extends StatefulWidget {
  const AutoCompleteDemo({Key? key}) : super(key: key);

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  var kGoogleApiKey = 'AIzaSyBtmA2MsfljS60NA3c_ljiVXC5gvv8TIFg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                Prediction? p = await PlacesAutocomplete.show(
                    region: 'pk',
                    context: context,
                    apiKey: kGoogleApiKey,
                    mode: Mode.overlay, // Mode.fullscreen
                    language: "pk",
                    components: [new Component(Component.country, "pk")]);
                displayPrediction(p!, homeScaffoldKey.currentState!);
              },
              child: Text("TEST"),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }

    void finalPlace(String placename) async {
      if (placename.length > 1) {
        String autoCompleteUrl =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+Amphittheatre&key=AIzaSyBtmA2MsfljS60NA3c_ljiVXC5gvv8TIFg&sessiontoken=1234567890';
      }
    }
  }
}

class AutoCompleteTest extends StatefulWidget{
  @override
  _AutoCompleteTestState createState() => _AutoCompleteTestState();
}

class _AutoCompleteTestState extends State<AutoCompleteTest> {
   String googleApikey = "332";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027); 
  String location = "Search Location"; 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Place Search Autocomplete Google Map"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller; 
                    });
                  },
             ),

           

             //search autoconplete input
             Positioned(  //search input bar
               top:10,
               child: 
               InkWell(
                 onTap: () async {
                  var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'pk')],
                                      //google_map_webservice package
                          onError: (err){
                             print(err);
                          }
                      );

                   if(place != null){
                        setState(() {
                          location = place.description.toString();
                        });

                       //form google_maps_webservice package
                       final plist = GoogleMapsPlaces(apiKey:googleApikey,
                              apiHeaders: await GoogleApiHeaders().getHeaders(),
                                        //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);
                        print(newlatlang);
                        

                        //move map camera to selected place with animation
                        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                   }
                 },
                 child:Padding(
                   padding: EdgeInsets.all(15),
                    child: Card(
                       child: Container(
                         padding: EdgeInsets.all(0),
                         width: MediaQuery.of(context).size.width - 40,
                         child: ListTile(
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            trailing: Icon(Icons.search),
                            dense: true,
                         )
                       ),
                    ),
                 )
               )
             ),
             Positioned(top: 80, child: ElevatedButton(onPressed: (){
              //  print(new)
             },child: Text("HELLO"),))



            ]
          )
       );
  }
}
