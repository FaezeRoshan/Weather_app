import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';

class CurrentCityModel extends CurrentCityEntity {
  CurrentCityModel({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
   // Rain? rain,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) : super(
         coord: coord,
         weather: weather,
         base: base,
         main: main,
         visibility: visibility,
         wind: wind,
      //   rain: rain,
         clouds: clouds,
         dt: dt,
         sys: sys,
         timezone: timezone,
         id: id,
         name: name,
         cod: cod,
       );

  factory CurrentCityModel.fromJson(dynamic json) {
   
    
    return CurrentCityModel(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: (json['weather'] as List)
          .map((w) => Weather.fromJson(w))
          .toList(),
      base: json['base'],
      main:  json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
    //  rain:json['rain'] != null ? Rain.fromJson(json['rain']) : null, 
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod']
    );
  }
}

class Clouds {
  int all;

  Clouds({required this.all});
  
   factory Clouds.fromJson(json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Coord {
  double lon;
  double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson( json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int seaLevel;
  int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });
  
  factory Main.fromJson( json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }
}

/*class Rain {
  double the1H;

  Rain({required this.the1H});

    factory Rain.fromJson( json) {
    return Rain(
      the1H: json['1h'].toDouble(),
    );
  }
}*/

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });
  
  factory Sys.fromJson( json) {
    return Sys(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
  
  factory Weather.fromJson(json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

}

class Wind {
  double speed;
  int deg;
 // double gust;

  Wind({required this.speed, required this.deg, });
  
  factory Wind.fromJson( json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
    //  gust: json['gust'].toDouble(),
    );
  }
}
