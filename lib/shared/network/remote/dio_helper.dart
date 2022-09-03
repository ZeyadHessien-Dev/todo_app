import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }


  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
