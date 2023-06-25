import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trails extends StatefulWidget {
  final String id;

  const Trails({Key? key, required this.id}) : super(key: key);

  @override
  State<Trails> createState() => _TrailsState();
}

class _TrailsState extends State<Trails> {
  @override
// make sure to initialize before map loading
  //final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Trails')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data!.data();
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Trails')
                        .doc(widget.id)
                        .collection('Cordinates')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshots) {
                      if (snapshots.hasError) {}
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<LatLng> points = List.generate(
                          snapshots.data!.docs.length,
                          (index) =>
                              LatLng(index.toDouble(), index.toDouble()));
                      List<Marker> markers = [];
                      List<Polyline> polylines = [];
                      for (var element in snapshots.data!.docs) {
                        points[element['pos']] = LatLng(
                            double.parse(element['Latitude']),
                            double.parse(element['Longitude']));
                        //points.add(LatLng(double.parse(element['Latitude']),
                        //    double.parse(element['Longitude'])));
                        //_polylines.add(Polyline(polylineId: PolylineId('1'), points: LatLng(double.parse(element['Latitude']), double.parse(element['Longitude'])),color: Colors.green,width: 7));
                        markers.add(Marker(
                          markerId: MarkerId(element['Name']),
                          position: LatLng(
                              double.parse(element['Latitude']),
                              double.parse(element['Longitude'])),
                          onTap: () {},
                          //  icon: icon
                        ));
                      }
                      polylines.add(Polyline(
                          polylineId: const PolylineId('1'),
                          points: points,
                          color: Colors.purple,
                          width: 7));
                      return GoogleMap(
                        mapType: MapType.terrain,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.parse(data!['StartLatitude']),
                                double.parse(data['StartLongitude'])),
                            zoom: 12),
                        markers: Set<Marker>.of(markers),
                        polylines: Set<Polyline>.of(polylines),
                        //onCameraMove: _onCameraMove,
                        gestureRecognizers: <Factory<
                            OneSequenceGestureRecognizer>>{
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        },
                      );
                    },
                  );
                }
                return const Text('Error');
              })
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection('Trails').snapshots(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {}
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return SizedBox(
          //       height: 500,
          //       child: ListView.builder(
          //           itemCount: snapshot.data!.docs.length,
          //           itemBuilder: (context, index) {
          //             var data = snapshot.data!.docs[index].data()
          //                 as Map<String, dynamic>;
          //             var id = snapshot.data!.docs[index].id;
          //             //print(id);
          //             //print('******************');
          //             return Column(
          //               children: [
          //                 Text(data['Name']),
          //                 StreamBuilder<QuerySnapshot>(
          //                   stream: FirebaseFirestore.instance
          //                       .collection('Trails')
          //                       .doc(widget.id)
          //                       .collection('Cordinates')
          //                       .snapshots(),
          //                   builder: (BuildContext context,
          //                       AsyncSnapshot<QuerySnapshot> snapshots) {
          //                     if (snapshots.hasError) {}
          //                     if (snapshots.connectionState ==
          //                         ConnectionState.waiting) {
          //                       return const Center(
          //                         child: CircularProgressIndicator(),
          //                       );
          //                     }
          //                     List<LatLng> points = List.generate(snapshots.data!.docs.length, (index) => LatLng(index.toDouble(), index.toDouble()));
          //                     List<Marker> markers = [];
          //                     List<Polyline> polylines = [];
          //                     for (var element in snapshots.data!.docs) {
          //                       points[element['pos']]=LatLng(double.parse(element['Latitude']), double.parse(element['Longitude']));
          //                       //points.add(LatLng(double.parse(element['Latitude']),
          //                       //    double.parse(element['Longitude'])));
          //                       //_polylines.add(Polyline(polylineId: PolylineId('1'), points: LatLng(double.parse(element['Latitude']), double.parse(element['Longitude'])),color: Colors.green,width: 7));
          //                       markers.add(Marker(
          //                           markerId: MarkerId(element['Name']),
          //                           position: LatLng(
          //                               double.parse(element['Latitude']),
          //                               double.parse(element['Longitude'])),
          //                         onTap: (){}
          //                       ));
          //                     }
          //                     polylines.add(Polyline(
          //                         polylineId: const PolylineId('1'),
          //                         points: points,
          //                         color: Colors.green,
          //                         width: 7));
          //                     return SizedBox(
          //                         height: 500,
          //                         child: GoogleMap(
          //                           mapType: MapType.terrain,
          //                           initialCameraPosition: CameraPosition(
          //                               target: LatLng(
          //                                   double.parse(data['StartLatitude']),
          //                                   double.parse(data['StartLongitude'])),
          //                               zoom: 14.4746),
          //                           markers: Set<Marker>.of(markers),
          //                           polylines: Set<Polyline>.of(polylines),
          //                           //onCameraMove: _onCameraMove,
          //                           gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          //                             Factory<OneSequenceGestureRecognizer>(
          //                                   () => EagerGestureRecognizer(),
          //                             ),
          //                           },
          //                         )
          //                         // }),
          //                         );
          //                   },
          //                 ),
          //               ],
          //             );
          //           }),
          //     );
          //   },
          // ),
          ),
    );
  }
}
