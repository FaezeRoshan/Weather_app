import 'package:weather/core/resources/data_state.dart';
import 'package:weather/core/use_case/use_case.dart';
import 'package:weather/features/feature_bookmark/domain/repository/city_repository.dart';

class DeleteCityUsecase implements UseCase<DataState<String>, String> {
  final CityRepository cityRepository;

  DeleteCityUsecase(this.cityRepository);

  @override
  Future<DataState<String>> call(String param) {
    return cityRepository.deleteCityByName(param);
  }
}
