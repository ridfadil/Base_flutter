import 'package:flutter_base_project/data/session.dart';

Future getHeadersAPI() async {
  Map<String, String> header = {};
  header.clear();
  header["Cache-Control"] = "no-cache";
  header["app"] = await Session.getAppId();
  header["token"] = await Session.getToken();
  header["role"] = await Session.getRole();
  print("HEADERSS: " + header.toString());
  return header;
}

Future getRoleUser() async {
  return await Session.getRole();
}
