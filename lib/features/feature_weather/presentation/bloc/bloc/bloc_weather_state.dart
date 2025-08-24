part of 'bloc_weather_bloc.dart';

class BlocWeatherState extends Equatable {
  final CwStatus cwStatus;
  final FwStatus fwStatus;

  const BlocWeatherState({required this.cwStatus, required this.fwStatus});

  BlocWeatherState copyWith({CwStatus? newCwStatus, FwStatus? newFwStatus}) {
    return BlocWeatherState(
      cwStatus: newCwStatus ?? cwStatus,
      fwStatus: newFwStatus ?? fwStatus,
    );
  }

  @override
  List<Object?> get props => [fwStatus, cwStatus];
}
