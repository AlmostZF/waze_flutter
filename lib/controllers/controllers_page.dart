// ignore_for_file: unnecessary_new
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_dart/models/model_files.dart';
import 'package:learning_dart/models/model_users.dart';
import 'package:learning_dart/service/register_image.dart';
import 'package:learning_dart/service/register_users.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

class ControllerPage {
  //variaveis
  VoidCallback? func;
  String tileLayers = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  List<String> domains = ['a', 'b', 'c'];
  List<Marker> markers = [];
  List<CircleMarker> circles = [];
  List<Polyline> polyline = [];
  double latitude = 0.0;
  double longitude = 0.0;
  double latitudeDestiny = 0.0;
  double longitudeDestiny = 0.0;
  MapController controllerMap = new MapController();
  //actions
  Future<void> onMapCreate() async {
    await Geolocator.requestPermission();
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
              color: Colors.amber,
              size: 45,
            )));
  }

  Future<void> addCircleInMap(LatLng latLng) async {
    double metters = await Geolocator.distanceBetween(
        latitude, longitude, latLng.latitude, latLng.longitude);
    print(metters);
    circles.add(CircleMarker(
        point: latLng,
        radius: 60.0,
        color: metters <= 60.0
            ? Colors.red.withOpacity(0.4)
            : Colors.cyan.withOpacity(0.2)));
    func?.call();
  }

    Future<PolylineResult> polylines(LatLng latlng) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      //Chave de acesso
      PointLatLng(latlng.latitude, latlng.longitude),
      PointLatLng(latitudeDestiny, longitudeDestiny),
      travelMode: TravelMode.driving,
    );
    return result;
  }

  Future<void> addPolylineInMap(LatLng latLng) async {
    latitudeDestiny = latLng.latitude;
    latitudeDestiny = latLng.latitude;
    List <LatLng> points = [];
        PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      //Chave de acesso,
      PointLatLng(latitude, longitude),
      PointLatLng(latitudeDestiny, longitudeDestiny),
      travelMode: TravelMode.driving,
    );
    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
    }
    polyline.add(Polyline(points: points, color: Colors.lightGreenAccent.withOpacity(0.8), strokeWidth: 10.0));
    markers.add(Marker(
      builder: (ctx) => const Icon(
        Icons.location_pin,
        color: Colors.amber,
        size: 40,),
      point: LatLng(latitude, longitude)));
    latitudeDestiny = points.last.latitude;
    longitudeDestiny = points.last.longitude;
    polyline.clear();
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
        .add(Polyline(points: points, color: Colors.lightGreenAccent.withOpacity(0.8), strokeWidth: 10.0));
        double heading = SphericalUtils.computeHeading(
        Point(points[0].latitude, points[0].longitude),
        Point(points[1].latitude, points[1].longitude));
    func?.call();
    }
  
}
