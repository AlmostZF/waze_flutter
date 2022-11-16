import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/controller_map.dart';
import 'package:flutter_application_1/controller/controller_pages.dart';
import 'package:flutter_application_1/service/service_user_login.dart';
import 'package:flutter_application_1/utils/save_token.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ControllerMap controllerMap = ControllerMap();
  Controller controller =  Controller();
  //ControllerLogout controllerLogout = ControllerLogout();

  StreamSubscription<Position>? listenPosition;

  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniciar();
    controllerMap.func = updateState;
    controllerMap.onMapCreate();
    Future.delayed(Duration(seconds: 10), () {
      listenCordenates();
    });
  }
  void iniciar () {
    setState(() {
      
    });
  }

  void listenCordenates() {
    listenPosition = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                distanceFilter: 0,
                accuracy: LocationAccuracy.best,
                timeLimit: Duration(seconds: 10)))
        .listen((event) {
      print('localização alterada');
      if (controllerMap.checkPoint){
        controllerMap.navigateInMap(event.latitude, event.longitude);
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
    return  Scaffold(
      appBar: AppBar(
        title:
                Text(controllerMap.displayName),
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
            actions: <Widget> [
              IconButton(onPressed: () async{
                await SaveToken?.removeAllTokens();
                Navigator.of(context).pushReplacementNamed('/login_page');
              }, icon: const Icon(Icons.logout))
            ],
        leading: controllerMap.photoUrl == null
                ? Container(
                    child: const  CircularProgressIndicator(
                      color: Color.fromARGB(254, 30, 50, 75),
                    ),
                  )
                :Padding(
                    padding: EdgeInsets.all(size.width*0.02),
                    child: ClipOval(
                        child: Image(
                      image: NetworkImage("${controllerMap.photoUrl}"),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  ),
                 ),
      ),
       body: Container(
        child: SingleChildScrollView(
            child: SizedBox(
          height: size.height,
          child: Container(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-19.9816, -44.99562),
                zoom: 12.0,
                controller: controllerMap.controllerMap,
                onTap: (tapPosition, point) =>
                    controllerMap.addCircleInMap(point),
                //onMapCreated: (e) => controller.onMapCreate()
              ),
              mapController: controllerMap.controllerMap,
              layers: [
                TileLayerOptions(
                  urlTemplate: controllerMap.tileLayers,
                  subdomains: controllerMap.domains,
                ),
                MarkerLayerOptions(markers: controllerMap.markers),
                MarkerLayerOptions(markers: controllerMap.markersPoint),
                CircleLayerOptions(circles: controllerMap.circles),
                PolylineLayerOptions(
                polylineCulling: true,
                polylines: controllerMap.polyline),
              ],
            ),
          ),
        )),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            controllerMap.onMapCreate();
            setState(() {
              
            });
          }, child: Icon(Icons.gps_fixed)),
    );
  }
}
