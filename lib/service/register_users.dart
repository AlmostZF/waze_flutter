import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learning_dart/core/custom_http.dart';
import 'package:learning_dart/utils/endpoints.dart';

class ServiceUsers {
  CustomHttp _http = new CustomHttp();

  Future<int> registerUser(Map body) async {
    try {
      Response response = await _http.client
          .post(Endpoint.registerUser, data: json.encode(body));
      return response.statusCode!;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
      return e.response!.statusCode!;
    }
  }

  Future<List> getUsers() async {
    try {
      Response response = await _http.client
          .get(Endpoint.registerUser);
      return response.data['DATA'];
    } on DioError catch (e) {
      return [];
    }
  }

}
