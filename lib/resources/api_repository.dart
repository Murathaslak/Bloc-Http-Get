import 'package:flutter_bloc_http_get/model/covid_model.dart';
import 'package:flutter_bloc_http_get/resources/api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<CovidModel> fetchCovidList() {
    return provider.fetchCovidList();
  }
}

class NetworkError extends Error {}
