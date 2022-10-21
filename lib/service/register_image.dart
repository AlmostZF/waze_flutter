import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learning_dart/core/custom_http.dart';
import 'package:learning_dart/utils/endpoints.dart';

class ServiceImage {
  CustomHttp _http = new CustomHttp();
  Future<dynamic> registerImage(Map body) async {
    try {
      Response response = await _http.client
          .post(Endpoint.registerImage, data: json.encode(body));
      return response.data['DATA'];
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
      return null;
    }
  }

}
