import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/data/constants.dart';
import 'package:flutter_base_project/models/m_report.dart';
import 'package:flutter_base_project/models/m_report.dart';
import 'package:flutter_base_project/pages/items/i_report.dart';
import 'package:flutter_base_project/data/api_service.dart';
import 'package:flutter_base_project/utils/values/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentActivity extends StatefulWidget {
  @override
  _StudentActivityState createState() => _StudentActivityState();
}

class _StudentActivityState extends State<StudentActivity> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('List Report'),
          backgroundColor: MyColor.skyBlue,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              FutureBuilder<List<Data>>(

                  /// ini panggil API dengan snapshotnya
                  future: getReport(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        height: 100,
                        child: Center(child: Text(snapshot.error.toString())),
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text("Data tidak ditemukan"),
                            );
                          } else {
                            ///Dimasukan ke Item (Adapter)
                            return ItemReport(report: snapshot.data);
                          }
                        } else {
                          return Container(
                            height: 100,
                            child: Center(child: Text("Data tidak ditemukan")),
                          );
                        }
                        break;
                      default:
                        return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  ///Untuk Get Api
  Future<List<Data>> getReport() async {
    final Response responses = await ApiService.getReport(context: context);
    await Future<String>.delayed(const Duration(milliseconds: 300));
    if (responses.data != null &&
        responses.statusCode == APIResponseCode.SUCCESS) {
//      var res = new Map<String, dynamic>.from(responses.data);
      ReportResponse reportList = ReportResponse.fromJson(responses.data);
      return reportList.dataList;
    } else {
      Fluttertoast.showToast(
          msg: "Kesalahan : " + responses.toString(),
          toastLength: Toast.LENGTH_SHORT);
      return null;
    }
  }

  ///Untuk Get Api
//  Future<List<Data>> getReport() async {
//    final Response responses = await ApiService.getReport(
//        context: context);
//    await Future<String>.delayed(const Duration(milliseconds: 300));
//    if (responses.statusCode == APIResponseCode.SUCCESS) {
//      var res = new Map<dynamic, dynamic>.from(response.data);
//      ReportResponse reportList = ReportResponse.fromJson(res);
//      print(responses.data);
//      return reportList.dataList;
//    } else {
//      Fluttertoast.showToast(
//          msg: "Kesalahan : "+responses.statusCode.toString(), toastLength: Toast.LENGTH_SHORT);
//      return null;
//    }
//  }

  ///kalau add list static//////
  /*List GetStudent(){
    return[
      Students(
          id : 1,
          name: "fadil",
          email: "bbmfrd@gmail.com",
          age: 22
      ),Students(
          id : 1,
          name: "fadil",
          email: "bbmfrd@gmail.com",
          age: 23
      ),Students(
          id : 1,
          name: "fadil",
          email: "bbmfrd@gmail.com",
          age: 24
      ),Students(
          id : 1,
          name: "fadil",
          email: "bbmfrd@gmail.com",
          age: 25
      ),Students(
          id : 1,
          name: "fadil",
          email: "bbmfrd@gmail.com",
          age: 26
      ),
    ];
  }*/
}
