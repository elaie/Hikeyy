import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationFriends extends StatefulWidget {
  final String id;
  const LocationFriends({Key? key, required this.id}) : super(key: key);

  @override
  State<LocationFriends> createState() => _LocationFriendsState();
}

class _LocationFriendsState extends State<LocationFriends> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers=[];
  //late Position UserPositon;
  static late final CameraPosition _kGoogle;
  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    await Geolocator.getCurrentPosition().then((value){
     _kGoogle = CameraPosition(
        target: LatLng(value.latitude,value.longitude),
        zoom: 14.4746,
      );
    });
  }
  Future<void> getLocations()async {
    QuerySnapshot datas = await FirebaseFirestore.instance.collection('Groups').doc(widget.id).collection('Locations').get();
    datas.docs.forEach((element) {
      GeoPoint point = element['Position'];
      String id = element.id;
      //print(point.latitude );
      //print(point.longitude);
     // print('****************');
      _markers.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(point.latitude,point.longitude),
      ),);
    }
    );
    //return _markers;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocations();
   // _markers=getLocations() as List<Marker>;
     getUserCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: getLocations(),
        builder:(context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          return FutureBuilder(
            future: getUserCurrentLocation(),
              builder: (context,snap){
                if(snap.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
              return GoogleMap(
                // on below line setting camera position
                initialCameraPosition: _kGoogle,
                markers: Set<Marker>.of(_markers),
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
              );
              }
          );
        }
      ),
    );
  }
}
