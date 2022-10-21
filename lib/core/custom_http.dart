import 'package:dio/dio.dart';
import 'package:learning_dart/core/interceptors.dart';
import 'package:learning_dart/utils/endpoints.dart';

class CustomHttp {
  Dio client = Dio();
  CustomHttp() {
    client.options.baseUrl = Endpoint.baseUrl;
    client.options.connectTimeout = 600000;
    client.interceptors.add(InterceptorDIO());
    client.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      if (error.response?.statusCode == 401) {
        // refresh token
        return handler.resolve(error.response!);
      }
      return handler.next(error);
    }));
  }
  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    Dio dio,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    Response response = await dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
    return response;
  }
}
