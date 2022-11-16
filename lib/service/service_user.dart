import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/custom_http.dart';
import 'package:flutter_application_1/utils/endpoint.dart';


class ServiceUser {
  final CustomHttp _http = CustomHttp();
  Future<dynamic> registerUser(Map body) async {
    try {
      Response response =
          await _http.client.post(Endpoint.createUser, data: json.encode(body));
      return response.statusCode;
      print(response.data);
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
    }
  }
}
