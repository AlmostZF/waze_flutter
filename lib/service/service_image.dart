import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/custom_http.dart';
import 'package:flutter_application_1/utils/endpoint.dart';


class ServiceImage {
  CustomHttp _http = CustomHttp();
  Future<dynamic> registerImage(Map body) async {
    try {
      Response response = await _http.client
          .post(Endpoint.registerImage, data: jsonEncode(body));
      return response.data['DATA'];
      print(response.data['docfile']);
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }
}
