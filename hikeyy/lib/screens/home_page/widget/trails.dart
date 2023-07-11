
import 'package:flutter/material.dart';
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
