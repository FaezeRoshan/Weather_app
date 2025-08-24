import 'package:equatable/equatable.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class GetCityStatus extends Equatable {}

class GetCityLoading extends GetCityStatus {
  @override
  List<Object?> get props => [];
}

class GetCityCompleted extends GetCityStatus {
  final City? city;

  GetCityCompleted(this.city);
  @override
  List<Object?> get props => [city];
}

class GetCityError extends GetCityStatus {
  final String? error;

  GetCityError(this.error);
  @override

  List<Object?> get props => [error];
}
