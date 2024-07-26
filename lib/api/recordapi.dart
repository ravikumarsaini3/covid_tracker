import 'dart:convert';

import 'package:flutter_application_1/api/url/url.dart';

import 'package:flutter_application_1/model/Worldrecord.dart';
import 'package:http/http.dart' as http;

class Recordapi {
  Future<Worldrecordmodel> getrecordapi() async {
    var data;
    final responce = await http.get(Uri.parse(appurl.recordurl));
    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body);
      return Worldrecordmodel.fromJson(data);
    } else {
      throw ('Somthing went wrong');
    }
  }

  Future<List<dynamic>> getcountry() async {
    var data;
    final responce = await http.get(Uri.parse(appurl.countriesurl));
    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body);
      return data;
    } else {
      throw ('Somthing went wrong');
    }
  }
}
