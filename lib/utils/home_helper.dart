import 'dart:convert';
import 'package:http/http.dart' as http;

import '../screen/home/model/home_model.dart';

class Apihelper {
  Future<CoronaModel> getCoronaApi() async {
    String apiLink =
        "https://corona-virus-world-and-india-data.p.rapidapi.com/api";
    Uri uri = Uri.parse(apiLink);
    var response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'e1ce1db1b6mshd5301ab816f5ff7p133682jsnd4862ef0f16d',
      'X-RapidAPI-Host': 'corona-virus-world-and-india-data.p.rapidapi.com',
      'content-type': 'application/octet-stream',
    });
    var json = jsonDecode(response.body);

    CoronaModel coronaModel = CoronaModel.fromJson(json);

    return coronaModel;
  }
}