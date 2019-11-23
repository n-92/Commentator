import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl = "https://v2-api.sheety.co//messages/messages/";

class API {

  static Future getComments(int id) {
    var url = baseUrl+ '$id';
    return http.get(url);
  }

  static Future<bool> postComments({String name="From App", String email= "gg@gg.com", @required String body,}) async{
    Map data = {"message":
                  {'name': '$name',
                    'email': '$email',
                    'body': '$body'}};
    var response = await http.post(baseUrl, headers: {"Content-Type": "application/json"}, body: json.encode(data));
    return response.statusCode == 200 ? true: false;
  }

}
