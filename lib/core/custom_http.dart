import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/endpoint.dart';
import 'package:flutter_application_1/utils/save_token.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'interceptors.dart';

class CustomHttp {
  Dio client = Dio();

  CustomHttp() {
    client.options.baseUrl = Endpoint.baseUrl;
    client.options.connectTimeout = 300000;
    client.interceptors.add(InterceptorDIO());
    client.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? token = await SaveToken?.getTokens('token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer ' + token;
      }
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      print('Erro1');
      print(error.response?.statusCode);
      if (error.response?.statusCode == 401) {
        // refresh token
        print('refresh');
        await refreshToken();
        return handler.resolve(await _retry(error.requestOptions));
      }
      else if (error.response?.statusCode == 400){
        Fluttertoast.showToast(msg: "Os campos não podem ficar vazio",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.teal,
      textColor: Colors.white,
      fontSize: 16.0);
      }
      else {
            Fluttertoast.showToast(msg: "Email ou senha inválidos",
       toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
       timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0);
      }
    }));
  }
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print('retry');
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    Response response = await Dio().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
    return response;
  }

  Future<void> refreshToken() async {
    final response = await client.post(Endpoint.refreshToken,
        data: {'refresh_token': await SaveToken?.getTokens('refresh_token')});
    if (response.statusCode == 201 || response.statusCode == 200) {
      await SaveToken?.saveTokens(
          'token', response.data['DATA']['access_token']);
      await SaveToken?.saveTokens(
          'refresh_token', response.data['DATA']['refresh_token']);
    } else {
      await SaveToken.removeAllTokens();
    }
  }
}
