import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/data/session.dart';
import 'package:flutter_base_project/models/m_report.dart';
import 'package:meta/meta.dart';

Map<String, String> params = {};
Map<String, String> body = {};
Response response;
FormData formData;
Dio dio;

class ApiService {
  static String BASE_URL = "http://premier.pragmainf.tech";

  /////////////// END POINT //////////////////////////
  static login(
      {@required BuildContext context,
      @required String email,
      @required String password}) async {
    params.clear();
    await _dioSetting(false);
    params['username'] = email;
    params['password'] = password;
//    print(params.toString());
    response = await dio.post("/auth/login", data: params);
//    print(response);
    return response;
  }

  static getReport({@required BuildContext context}) async {
    params.clear();
    try {
      Dio dio = await _dioSetting(true);
      response = await dio.get("/report");
//      print("AAA" + response.toString());
      return response;
    } on DioError catch (e) {
      return ReportResponse.fromJson({'message': e.message});
    }
  }

  ///////////////// Settings Dio /////////////////////////////
  static _dioSetting(bool isHeader) async {
    dio = new Dio();
//    dio.options.baseUrl = BASE_URL;
//    dio.options.connectTimeout = 5000; //5s
//    dio.options.receiveTimeout = 3000;
    if (isHeader) dio.options.headers = await getHeaders();

    BaseOptions options = new BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        });
    return dio = new Dio(options);
  }

  //Tambah Kalau Ada Headers disini
  static getHeaders() async {
    Map<String, String> header = {};
    header.clear();
    String token = await Session.getToken();
    header = {
      "Authorization": "Bearer " + token,
      "Accept": "application/json",
    };
    print("HEADERSS: " + header.toString());
    return header;
  }
}
