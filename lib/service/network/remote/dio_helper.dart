import 'package:dio/dio.dart';
import '../local/DbHelper.dart';

//Dio Helper That's Connect and Talk to API.
class DioHelper {
  static late Dio dio;


  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.
        baseUrl: 'https://talabatek.net/',
        validateStatus: (_) => true,

        //   receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Accept': 'application/json',
          'authorization': 'token ${CacheHelper.getData(key: 'access').toString()}',
        },
      ),
    );
  }
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? data})async{
    dio.options.headers = {
    //  'Accept-Language':prefs.getBool('isArabic')  == false ? "en" : "ar",
      "Authorization": "Bearer ${CacheHelper.getData(key: "access").toString()}"
    };
    return await dio.get(url,queryParameters: data);
  }
  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> patchData({
    required String url,
    required FormData data
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'*/*',
      'authorization': 'Bearer ${CacheHelper.getData(key: 'access').toString()}',
    };
    return await dio.patch(
      url,
      data: data,
    );
  }


  static Future<Response> SignUser({required String path,required Map<String,dynamic> data,}){
    dio.options.headers = {
      'Content-Type' : 'application/json',
    };
    return dio.post(path,data: data);
  }

  static Future<Response> postUser({required String path,required FormData data}){
    dio.options.headers = {
      'Accept':'*/*',

    };
    return dio.post(path,data: data);
  }
  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {

    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept':'*/*',
        'authorization': 'bearer ${CacheHelper.getData(key: 'access').toString()}',
      };
      final Response response = await dio.post(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  static Future<Response> postDataInside({
    required String url,
    required FormData data,

  }) async {

    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept':'*/*',
        'authorization': 'Bearer ${CacheHelper.getData(key: 'access').toString()}',
      };
      final Response response = await dio.post(
        url,
        data: data,

      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    //bool files = false,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept':'*/*',
        'authorization': 'Bearer ${CacheHelper.getData(key: 'access').toString()}',
      };
      final Response response = await dio.patch(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  //This Function that's Used To Delete Data to API based on URL(End Points) and Headers.
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    //String lang = 'en',
  }) async {
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'authorization': 'Bearer ${CacheHelper.getData(key: 'access')}',      };
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}