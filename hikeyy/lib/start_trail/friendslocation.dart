import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/profile_page/widgets/profile_picture.dart';
import '../screens/profile_page/widgets/user_name.dart';

class LocationFriends extends StatefulWidget {
  final String id;
  const LocationFriends({Key? key, required this.id}) : super(key: key);

  @override
  State<LocationFriends> createState() => _LocationFriendsState();
}

class _LocationFriendsState extends State<LocationFriends> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers=[];
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
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
    // BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(size: Size.square(1),
    //   devicePixelRatio: 10),
    //   "assets/images/profile.png",
    // );
    final Uint8List markerIcon = await getBytesFromAsset('assets/icons/profile.png', 60);
    QuerySnapshot datas = await FirebaseFirestore.instance.collection('Groups').doc(widget.id).collection('Locations').get();
    datas.docs.forEach((element) {
      GeoPoint point = element['Position'];
      String id = element.id;
      _markers.add(
        Marker(
        markerId: MarkerId(id),
        position: LatLng(point.latitude,point.longitude),
        icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: (){
            showDialog(
              context: context,
              builder: (context) => FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(id)
                    .get(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                    var data = snapshot.data!.data();
                    var name = data!['UserName'];
                    var pfp = data['pfpUrl'];
                    return AlertDialog(
                  content: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors
                                .blueAccent,
                            borderRadius:
                            BorderRadius
                                .circular(
                                200),
                            image: DecorationImage(
                                fit:
                                BoxFit.fill,
                                image: NetworkImage(pfp))),
                      ),
                     SizedBox(width: 10,),
                     Text(name)
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(),
                      child: new Text('Dismiss'),
                    ),
                  ],
                );}
              ),
            );
          }
      ),);
    }
    );
    //return _markers;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getLocations();
   // _markers=getLocations() as List<Marker>;
    // getUserCurrentLocation();
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
