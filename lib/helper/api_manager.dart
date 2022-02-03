import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_apis/models/newsinfo.dart';

import '../helper/Strings.dart';

class Api_Manager {
  Future<Welcome> getNews() async {
    var client = http.Client();
    var welcome = null;

    try {
      var response = await client.get(Uri.parse(Strings.news_url));
      if (response.statusCode == 200) {
        //sccuess case
        var jsonString = response.body; // parsing
        var jsonMap = json.decode(jsonString); //mapping
        welcome = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return welcome;
    }
    return welcome;
  }
}
