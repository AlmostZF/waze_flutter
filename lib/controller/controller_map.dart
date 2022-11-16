// ignore_for_file: unnecessary_new
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_application_1/service/service_user_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

class ControllerMap{
  //variaveis
  VoidCallback? func;
  String tileLayers = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  List<String> domains = ['a', 'b', 'c'];
  List<Marker> markers = [];
  List<Marker> markersPoint = [];
  List<CircleMarker> circles = [];
  List<Polyline> polyline = [];
  bool checkPoint = false;
  double latitude = 0.0;
  double longitude = 0.0;
  double latitudeDestiny = 0.0;
  double longitudeDestiny = 0.0;
  MapController controllerMap = MapController();
  String displayName = "";
  String? photoUrl ;
  //services
  ServiceLoginUser serviceLoginUser = ServiceLoginUser();
  
  //actions
  Future<void> onMapCreate() async {
    await Geolocator.requestPermission();
    serviceLoginUser.getUsers().then((displayInfoUsers) {
      displayName = displayInfoUsers['DATA']["name"];
      photoUrl = displayInfoUsers['DATA']["photoUrl"];
      print(photoUrl);
      func?.call();
    });
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await Geolocator.getCurrentPosition().then((result) {
        latitude = result.latitude;
        longitude = result.longitude;
        showMap();
        func?.call();
      }).catchError((result) => print(result));
    }
  }

  Future<void> showMap() async {
    controllerMap.move(LatLng(latitude, longitude), 17);
    markers.add(Marker(
        point: LatLng(latitude, longitude),
        builder: (ctx) => const Icon(
              Icons.location_history_rounded,
              color: Colors.lightBlue,
              size: 45,
            )));
  }

  Future<void> addCircleInMap(LatLng latLng) async {
    String distance = await Geolocator.distanceBetween(
        latitude, longitude, latLng.latitude, latLng.longitude).toStringAsFixed(2);
     Fluttertoast.showToast(
        msg: "Distância é de: ${distance} metros",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 18.0
    );
    double metters = await Geolocator.distanceBetween(
        latitude, longitude, latLng.latitude, latLng.longitude);
        circles.clear();
    circles.add(CircleMarker(
        point: latLng,
        radius: 60.0,
        color: metters <= 60.0
            ? Colors.greenAccent.withOpacity(0.4)
            : Colors.cyan.withOpacity(0.2)));
    func?.call();
    addPolylineInMap(latLng);
  }

    Future<PolylineResult> polylines(LatLng latlng) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      // Chave para usar a localição,
      PointLatLng(latlng.latitude, latlng.longitude),
      PointLatLng(latitudeDestiny, longitudeDestiny),
      travelMode: TravelMode.driving,
    );
    return result;
  }

  Future<void> addPolylineInMap(LatLng latLng) async {
    List <LatLng> points = [];
        PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      // Chave para usar a localição
      PointLatLng(latitude, longitude),
      PointLatLng(latLng.latitude, latLng.longitude),
      travelMode: TravelMode.driving,
    );
    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
    }
    checkPoint = true;
    polyline.clear();
    markersPoint.clear();
    polyline.add(Polyline(
      points: points, 
      color: Colors.black.withOpacity(0.8), 
      strokeWidth: 5.0));
    markersPoint.add(Marker(
      builder: (ctx) => const Icon(
        Icons.location_pin,
        color: Colors.lightBlue,
         size: 25,
         
        ),
      point: LatLng(latLng.latitude, latLng.longitude)));
    latitudeDestiny = points.last.latitude;
    longitudeDestiny = points.last.longitude;
        double heading = SphericalUtils.computeHeading(
        Point(points[0].latitude, points[0].longitude),
        Point(points[1].latitude, points[1].longitude));
    controllerMap.rotate(heading * (-1));
    func?.call();
    
  }

    Future<void> navigateInMap(double lat, double lng) async {
    List<LatLng> points = [];
    PolylineResult result = await polylines(LatLng(lat, lng));
    polyline.clear();
    func?.call();
    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
    }
    polyline
        .add(Polyline(points: points, color: Colors.blueAccent.withOpacity(0.8), strokeWidth: 5.0));
    double heading = SphericalUtils.computeHeading(
        Point(points[0].latitude, points[0].longitude),
        Point(points[1].latitude, points[1].longitude));
    controllerMap.rotate(heading * (-1));
    func?.call();
    }
  
}
