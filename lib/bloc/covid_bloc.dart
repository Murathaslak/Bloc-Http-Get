// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:flutter_bloc_http_get/bloc/covid_event.dart';
import 'package:flutter_bloc_http_get/bloc/covid_state.dart';
import 'package:flutter_bloc_http_get/resources/api_repository.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<CovidEvent>((event, emit) async {
      try {
        emit(CovidLoading());
        final covidList = await apiRepository.fetchCovidList();
        emit(CovidLoaded(covidList));
        if (covidList.error != null) {
          emit(CovidError(covidList.error));
        }
      } on NetworkError {
        emit(const CovidError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
