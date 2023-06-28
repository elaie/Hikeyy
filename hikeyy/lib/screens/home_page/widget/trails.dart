import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikeyy/screens/home_page/widget/mapwidget.dart';

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
        child: MapWidget(id: widget.id),
      ),
    );
  }
}
