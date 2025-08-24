import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBackground {
  static AssetImage getBackGroundImage() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('HH').format(now);
    if (6 > int.parse(formattedDate)) {
      return AssetImage('images/nightpic.jpg');
    } else if (18 > int.parse(formattedDate)) {
      return AssetImage('images/pic_bg.jpg');
    } else {
      return AssetImage('images/nightpic.jpg');
    }
  }

  static Image setIconForMain(description, height) {
    if (description == "clear sky") {
      return Image(
        image: AssetImage('images/icons8-sun-96.png'),
        height: height,
      );
    } else if (description == "few clouds") {
      return Image(
        image: AssetImage('images/icons8-partly-cloudy-day-80.png'),
        height: height,
      );
    } else if (description.contains("clouds")) {
      return Image(
        image: AssetImage('images/icons8-clouds-80.png'),
        height: height,
      );
    } else if (description.contains("thunderstorm")) {
      return Image(
        image: AssetImage('images/icons8-storm-80.png'),
        height: height,
      );
    } else if (description.contains("drizzle")) {
      return Image(
        image: AssetImage('images/icons8-rain-cloud-80.png'),
        height: height,
      );
    } else if (description.contains("rain")) {
      return Image(
        image: AssetImage('images/icons8-heavy-rain-80.png'),
        height: height,
      );
    } else if (description.contains("snow")) {
      return Image(
        image: AssetImage('images/icons8-snow-80.png'),
        height: height,
      );
    } else {
      return Image(
        image: AssetImage('images/icons8-windy-weather-80.png'),
        height: height,
      );
    }
  }


  static Image SetIconForecast(code, height){
    if (code == 0) {
      return Image(
        image: AssetImage('images/icons8-sun-96.png'),
        height: height,
      );
    } else if (code == 1 || code == 2 || code == 3) {
      return Image(
        image: AssetImage('images/icons8-partly-cloudy-day-80.png'),
        height: height,
      );
    } else if (code == 45 || code == 48) {
      return Image(
        image: AssetImage('images/icons8-clouds-80.png'),
        height: height,
      );
    } else if (code == 51 || code == 53 || code == 55) {
      return Image(
        image: AssetImage('images/icons8-rain-cloud-80.png'),
        height: height,
      );
    } else if (code == 61 ||
        code == 63 ||
        code == 65 ||
        code == 66 ||
        code == 67) {
      return Image(
        image: AssetImage('images/icons8-heavy-rain-80.png'),
        height: height,
      );
    } else if (code == 71 || code == 73 || code == 75|| code == 77|| code == 85|| code == 86) {
      return Image(
        image: AssetImage('images/icons8-snow-80.png'),
        height: height,
      );
    }else if (code == 96 || code == 99 || code == 95|| code == 80|| code == 81|| code == 82) {
      return Image(
        image: AssetImage('images/icons8-snow-80.png'),
        height: height,
      );
    }
    return Image(
        image: AssetImage('images/icons8-sun-96.png'),
        height: height,
      );
  }


}
