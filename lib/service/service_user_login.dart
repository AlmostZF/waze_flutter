import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/custom_http.dart';
import 'package:flutter_application_1/utils/endpoint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceLoginUser {
  final CustomHttp _http = CustomHttp();
  Future<dynamic> loginUser(Map body) async {
    try {
      Response response =
          await _http.client.post(Endpoint.loginUser, data: body);
      print(response);
      void setUsers() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = preferences
            .setString(
                'token',
                response.data['DATA']['userLoged']['user']['stsTokenManager']
                    ['accessToken'])
            .toString();
        print(token);
        String userId = preferences
            .setString(
                'userId', response.data['DATA']['userLoged']['user']['uid'])
            .toString();
        print(userId);
      }
      setUsers();
      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      print(e.message);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
    }
  }

  Future<dynamic> getUsers() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = preferences.getString('token').toString();
      String userId = preferences.getString('userId').toString();
      print(userId);
      Response response = await _http.client.get(
          Endpoint.getUser + userId);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
    }
  }
}