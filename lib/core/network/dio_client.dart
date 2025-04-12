import 'package:dio/dio.dart';

class DioClient{
  static Dio getDio(){
    Dio dio=Dio();
    dio.options.baseUrl="https://meatzo.com/api";
    dio.options.headers["Content-Type"]="application/json";
    return dio;


  }
}