import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/data/session.dart';
import 'package:flutter_base_project/models/m_report.dart';
import 'package:meta/meta.dart';

Map<String, String> params = {};
Map<String, String> body = {};
Response response;
FormData formData;

class ApiService {

  static String BASE_URL = "http://premier.pragmainf.tech";

  /////////////// END POINT //////////////////////////
  static login(
      {@required BuildContext context,
        @required String email,
        @required String password}) async {
    params.clear();
    Dio dio =  _dioSetting(false);
    params['username'] = email;
    params['password'] = password;
    print(params.toString());
    return response = await dio.post("/auth/login", data: params);
  }

  static getReport(
      {@required BuildContext context}) async {
    params.clear();
    try{
      Dio dio =  _dioSetting(true);
      return response = await dio.get("/report");
    }on DioError catch (e) {
      return ReportResponse.fromJson({'message': e.message});
    }
  }

  ///////////////// Settings Dio /////////////////////////////
  static _dioSetting(bool isHeader){
    Dio dio = new Dio();
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    if (isHeader)dio.options.headers = getHeaders();

    BaseOptions options = new BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        followRedirects: false,
        validateStatus: (status) { return status < 500;}
    );
    return dio = new Dio(options);
  }

  //Tambah Kalau Ada Headers disini
  static getHeaders() async {
    Map<String, String> header = {};
    header.clear();
    header = {
      "Authorization": "Bearer " + await Session.getToken(),
      "Accept": "application/json",
    };
    print("HEADERSS: " + header.toString());
    return header;
  }

}
