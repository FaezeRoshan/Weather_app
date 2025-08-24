import 'package:flutter/material.dart';
import 'package:weather/core/utils/data_converter.dart';
import 'package:weather/core/widgets/app_background.dart';
import 'package:weather/features/feature_weather/data/models/forecast_days_model.dart';

//import 'package:weather/features/feature_weather/presentation/widgets/date_conventer.dart';

// ignore: must_be_immutable
class DaysWeatherView extends StatelessWidget {
  final Daily mainDaily;
  final int index;
  DaysWeatherView({super.key, required this.mainDaily, required this.index});

  late AnimationController animationController;

  late Animation animation;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    double temp = mainDaily.temperature2MMean[index];
    DateTime date = mainDaily.time[index];
    int code = mainDaily.weatherCode[index];
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          width: 50,
          height: 50,
          child: Column(
            children: [
              Text(
                "${date.day} ${DateConverter.monthNumberToName(date.month)}",
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: AppBackground.SetIconForecast(
                  code,
                  height * .032,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  "${temp.round().toString()}°",
                  style: const TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
