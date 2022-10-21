import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:learning_dart/controllers/controllers_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  ControllerPage controller = new ControllerPage();

void updateState() {
  if (mounted) setState(() {});
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.onMapCreate();
    controller.func = updateState;
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox (
            height: size.height,
            child: Card(
              elevation: 4,
              child: Container(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(-19.9816, -44.99562),
                    zoom: 12.0,
                    controller: controller.controllerMap,
                    onTap: (tapPosition, point) =>
                    controller.addCircleInMap(point),
                    //onMapCreated: (e) => controller.onMapCreate()
                  ),
                  mapController: controller.controllerMap,
                  layers: [
                    TileLayerOptions(
                      urlTemplate: controller.tileLayers,
                      subdomains: controller.domains,
                    ),
                     MarkerLayerOptions(markers: controller.markers),
                     CircleLayerOptions(circles: controller.circles),
                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
}
