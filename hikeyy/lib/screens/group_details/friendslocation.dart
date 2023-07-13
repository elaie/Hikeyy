import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../checkpoint_detail_page/checkpoint_detail_page.dart';


class LocationFriends extends StatefulWidget {
  final String id;

  const LocationFriends({Key? key, required this.id}) : super(key: key);

  @override
  State<LocationFriends> createState() => _LocationFriendsState();
}

class _LocationFriendsState extends State<LocationFriends> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];
  List<Polyline> polylines = [];

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //late Position UserPositon;
  static late final CameraPosition _kGoogle;

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      //print("ERROR" + error.toString());
    });
    await Geolocator.getCurrentPosition().then((value) {
      _kGoogle = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14.4746,
      );
    });
  }

  Future<void> getTrail() async {
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) async {
      Map<String, dynamic>? data = snapshot.data();
      QuerySnapshot datas = await FirebaseFirestore.instance
          .collection('Trails')
          .doc(data!['Trail'])
          .collection('Cordinates')
          .get();
      List<LatLng> points = List.generate(datas.docs.length,
          (index) => LatLng(index.toDouble(), index.toDouble()));
      for (var element in datas.docs) {
        String lat = element['Latitude'];
        String lon = element['Longitude'];
        int pos = element['pos'];
        points[pos] = LatLng(double.parse(lat), double.parse(lon));
        _markers.add(Marker(
          markerId: MarkerId(element['Name']),
          position: LatLng(double.parse(element['Latitude']),
              double.parse(element['Longitude'])),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>CheckpointDetailPage( id: element.id,trailid: data!['Trail'],)));
          },
          //  icon: icon
        ));
        polylines.add(Polyline(
            polylineId: const PolylineId('1'),
            points: points,
            color: Colors.purple,
            width: 7));
      }
    });

    // print(datas.get('Trails'));
    // print('##################aaaaa');
  }
  Future<Uint8List> loadImage(String url)async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(url);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info,_)=> completer.complete(info))
    );
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> getLocations() async {

    QuerySnapshot datas = await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .collection('Locations')
        .get();
    datas.docs.forEach((element) async {
      GeoPoint point = element['Position'];
      String id = element.id;
      if (id != FirebaseAuth.instance.currentUser!.uid) {
        DateTime time = element['Time'].toDate();
        DocumentSnapshot dataFriends = await FirebaseFirestore.instance
            .collection('Users')
            .doc(id)
            .get();
        String pfp = dataFriends.get('pfpUrl');
        String name = dataFriends.get('UserName');
        Uint8List? image = await loadImage(pfp);
        final ui.Codec markerImage = await instantiateImageCodec(
          image.buffer.asUint8List(),
          targetHeight: 80,
          targetWidth: 80
        );
        final ui.FrameInfo frameInfo =await markerImage.getNextFrame();
        final ByteData? byteData = await frameInfo.image.toByteData(
          format: ui.ImageByteFormat.png
        );
        final Uint8List resixedImageMarker = byteData!.buffer.asUint8List();
        _markers.add(
          Marker(
              infoWindow: InfoWindow(
                  title: name, snippet: '${time.hour}:${time.minute}'),
              markerId: MarkerId(id),
              position: LatLng(point.latitude, point.longitude),
              icon: BitmapDescriptor.fromBytes(resixedImageMarker),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(id)
                              .get(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            var data = snapshot.data!.data();
                            var name = data!['UserName'];
                            var pfp = data['pfpUrl'];
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(
                                            200),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(pfp))),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(name)
                                ],
                              ),
                              content: Text("Last Updated :${time.year}|${time.month}|${time.day} ${time.hour}:${time.minute} "),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Dismiss'),
                                ),
                              ],
                            );
                          }),
                );
              }),
        );
      }
    });
    //return _markers;
  }

  @override
  void initState() {
    super.initState();
    getTrail();
    // getLocations();
    // _markers=getLocations() as List<Marker>;
    // getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: getLocations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return FutureBuilder(
                future: getUserCurrentLocation(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return FutureBuilder(
                      future: getTrail(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return GoogleMap(
                          // on below line setting camera position
                          initialCameraPosition: _kGoogle,
                          markers: Set<Marker>.of(_markers),
                          polylines: Set<Polyline>.of(polylines),
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          compassEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        );
                      });
                });
          }),
    );
  }
}
