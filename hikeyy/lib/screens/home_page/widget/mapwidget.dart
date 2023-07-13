import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikeyy/screens/checkpoint_detail_page/checkpoint_detail_page.dart';

class MapWidget extends StatelessWidget {
  final String id;
  const MapWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Trails')
                  .doc(id)
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
                        .doc(id)
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
                          onTap: () {
                            print(id);
                            print(element.id);
                            print('**********');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>CheckpointDetailPage( id: element.id,trailid: id,)));
                          },
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
                            zoom: 10),
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
              }
      );
  }
}
