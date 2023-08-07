// 🎯 Dart imports:
// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

import 'app.dart';

class BaseNetworkProvider {
  //#region PRIVATE
  static String _buildUrl(String partUrl) {
    if (partUrl.startsWith('http')) return partUrl;
    return "http://185.81.152.101:8080/api/$partUrl/";
  }

  static Dio _getDio({bool withToken = false}) {
    final AppController app = g.Get.find();
    final Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      'Accept': '*/*'
    };
    if (withToken) {
      AppController app = g.Get.find();
      String accessToken =
          // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjIzNTAwNzYzOTE2IiwibmFtZWlkIjoidGVzdHVzZXItMTAwOS0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwicm9sZSI6Ikluc3VyZWQiLCJqdGkiOiIzNWI1ZDQyNjgyYzY0ZjM0YTY3YmE3NTQxNTY2ODBlYyIsImlhdCI6MTY3ODY4ODg2NCwibmJmIjoxNjc4Njg4ODY0LCJleHAiOjE2Nzg2ODk0NjQsImlzcyI6ImJpcmV5c2VsLm1hZ2RlYnVyZ2VyLmNvbS50ciIsImF1ZCI6ImJpcmV5c2VsLm1hZ2RlYnVyZ2VyLmNvbS50ciJ9.CAo21RztUk1uH-eBWdfEByPtiyhXxmCat5NIHmyVxJY";
          app.token ?? '';
      headers["Authorization"] = "Bearer $accessToken";
    } else {}
    Dio dio = Dio();
    dio.options.contentType = "application/json";
    dio.options.headers.addAll(headers);

    return dio;
  }

  // static Future<Dio> _getDioWithToken() async {
  //   Dio dio = _getDio(withToken: true);
  //   dio.interceptors
  //     ..clear()
  //     ..add(
  //       QueuedInterceptorsWrapper(
  //         onError: (error, handler) async {
  //           if (error.response?.statusCode == HttpStatus.unauthorized) {
  //             var options = error.response!.requestOptions;
  //             var newToken = await _userRefreshToken();
  //             if (newToken.isEmpty) return handler.next(error);
  //             options.headers[Keys.authorization] = "${Keys.bearer}$newToken";
  //             dio.options = BaseOptions(
  //               baseUrl: options.baseUrl,
  //               contentType: options.contentType,
  //               connectTimeout: options.connectTimeout,
  //               extra: options.extra,
  //               followRedirects: options.followRedirects,
  //               headers: options.headers,
  //               listFormat: options.listFormat,
  //               maxRedirects: options.maxRedirects,
  //               method: options.method,
  //               queryParameters: options.queryParameters,
  //               receiveDataWhenStatusError: options.receiveDataWhenStatusError,
  //               receiveTimeout: options.receiveTimeout,
  //               requestEncoder: options.requestEncoder,
  //               responseDecoder: options.responseDecoder,
  //               responseType: options.responseType,
  //               sendTimeout: options.sendTimeout,
  //               validateStatus: options.validateStatus,
  //             );
  //           }
  //           return handler.next(error);
  //         },
  //       ),
  //     );
  //   return dio;
  // }

  // static Future<String> _userRefreshToken() async {
  //   final AuthController auth = g.Get.find();

  //   var dio = _getDio();
  //   try {
  //     final response = await dio.post(
  //       _buildUrl(ApiUrl.usersRefreshToken),
  //       data: {Keys.refreshToken: Box.auth.refreshToken},
  //     );
  //     final body = response.data;
  //     if (body != null) {
  //       var newToken = body[Keys.data][Keys.accessToken];
  //       Auth a = Auth.fromMap(body[Keys.data]);
  //       auth.setAuth(a);
  //       return newToken ?? "";
  //     }
  //     return "";
  //   } catch (exception) {
  //     return "";
  //   }
  // }

  //#endregion

  //#region METHODS
  static Future<dynamic> get(String partUrl, {bool withToken = false}) async {
    try {
      var dio = _getDio(withToken: withToken);
      var url = _buildUrl(partUrl);

      final response = await dio.get(url);
      return response;
    } on DioError catch (error) {
      return {"success": false};
    }
  }

  static Future<dynamic> post(String partUrl, Map<String, dynamic> data,
      {bool withToken = false}) async {
    try {
      var dio = _getDio(withToken: withToken);
      var url = _buildUrl(partUrl);

      final response = await dio.post(url, data: data);
      return response;
    } on DioError catch (error) {
      return {"success": false};
    }
  }
}
