import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_http_get/model/covid_model.dart';

class ApiProvider {
  Future<CovidModel> fetchCovidList() async {
    const url = "https://api.covid19api.com/summary";
    try {
      final response = await http.get(Uri.parse(url));
      return CovidModel.fromJson(jsonDecode(response.body));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured : $error stackTrace: $stacktrace");
      }
      return CovidModel.withError("Data not found / Connection issue");
    }
  }
}
