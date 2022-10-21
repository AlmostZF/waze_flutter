import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning_dart/controllers/controllers_page.dart';

class PolylineScreen extends StatefulWidget {
  PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  ControllerPage controller = new ControllerPage();
  StreamSubscription<Position>? listenPosition;

  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.onMapCreate();
    controller.func = updateState;
    Future.delayed(Duration(minutes: 1), () {
      listenCoordinates();
    });
  }

  void listenCoordinates() {
    listenPosition = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                distanceFilter: 0,
                accuracy: LocationAccuracy.best,
                timeLimit: Duration(seconds: 5)))
        .listen((event) {
      print('localização alterada');
      if (controller.latitudeDestiny != 0.0 || controller.longitude != 0.0) {
        controller.navigateInMap(event.latitude, event.longitude);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listenPosition?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: SizedBox(
          height: size.height,
          child: Card(
            elevation: 4,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-19.9816, -44.99562),
                zoom: 12.0,
                controller: controller.controllerMap,
                onTap: (tapPosition, point) =>
                    controller.addPolylineInMap(point),
                //onMapCreated: (e) => controller.onMapCreate()
              ),
              mapController: controller.controllerMap,
              layers: [
                TileLayerOptions(
                  urlTemplate: controller.tileLayers,
                  subdomains: controller.domains,
                ),
                MarkerLayerOptions(markers: controller.markers),
                PolylineLayerOptions(
                    polylineCulling: true, polylines: controller.polyline),
                MarkerLayerOptions(markers: controller.markers),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
