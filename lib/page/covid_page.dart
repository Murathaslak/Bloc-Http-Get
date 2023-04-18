import 'package:flutter/material.dart';
import 'package:flutter_bloc_http_get/bloc/covid_bloc.dart';
import 'package:flutter_bloc_http_get/bloc/covid_event.dart';
import 'package:flutter_bloc_http_get/bloc/covid_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_http_get/model/covid_model.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({super.key});

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBloc covidBloc = CovidBloc();

  @override
  void initState() {
    covidBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("COVID-19")),
      body: buildListCovid(),
    );
  }

  Widget buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) => covidBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return buildLoading();
              } else if (state is CovidLoading) {
                return buildLoading();
              } else if (state is CovidLoaded) {
                return buildCard(context, state.covidModel);
              } else if (state is CovidError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() => const Center(child: CircularProgressIndicator());

  Widget buildCard(BuildContext context, CovidModel model) {
    return ListView.builder(
      itemCount: model.countries!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Country: ${model.countries![index].country}".toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Confirmed: ${model.countries![index].totalConfirmed}"
                    .toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Deaths: ${model.countries![index].totalDeaths}"
                    .toUpperCase(),
              ),
              const SizedBox(height: 10),
              Text(
                "Total Recovered: ${model.countries![index].totalRecovered}"
                    .toUpperCase(),
              ),
            ],
          ),
        );
      },
    );
  }
}
