import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class SaveCityStatus extends Equatable {}

class SaveCityInitial extends SaveCityStatus {
  @override
  List<Object?> get props => [];
}

class SaveCityLoading extends SaveCityStatus {
  @override
  List<Object?> get props => [];
}

class SaveCityCompeleted extends SaveCityStatus {
  final City city;

  SaveCityCompeleted(this.city);
  @override
  List<Object?> get props => [city];
}

class SaveCityError extends SaveCityStatus {
  final String? error;

  SaveCityError(this.error);
  @override
  
  List<Object?> get props => [error];
}
