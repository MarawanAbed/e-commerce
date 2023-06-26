import 'package:dio/dio.dart';

class DioHelper
{
  static Dio? dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? query,
    String lang='en',
    String? token,

}   )async
  {
    //this header replace the original in the init
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token ??'',
    };
    return await dio!.get(url,queryParameters: query);
  }


  static Future<Response> postData({
    required String url,
     Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang='en',
    String? token,
  })async
  {
    //here header that is change when i call post
    dio!.options.headers={
      'lang':lang,
      'Authorization':token,
    };
    return dio!.post(
        url,
        queryParameters: query,
        data: data,
    );
  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang='en',
    String? token,
  })async
  {
    //here header that is change when i call post
    dio!.options.headers={
      'lang':lang,
      'Authorization':token,
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}