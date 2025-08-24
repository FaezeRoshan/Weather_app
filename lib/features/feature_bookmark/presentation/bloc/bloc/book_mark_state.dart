part of 'book_mark_bloc.dart';

class BookMarkState extends Equatable {
  final SaveCityStatus saveCityStatus;
  final GetCityStatus getCityStatus;
  final GetAllCityStatus getAllCityStatus;
  final DeleteCityStatus deleteCityStatus;

  BookMarkState({required this.getAllCityStatus,required this.deleteCityStatus, required this.saveCityStatus, required this.getCityStatus});

  BookMarkState copyWith({
    SaveCityStatus? newsaveCityStatus,
    GetCityStatus? newgetCityStatus,
    GetAllCityStatus? newGetAllCityStatus,
    DeleteCityStatus? newDeleteCityStatus
  
  }) {
    return BookMarkState(
      saveCityStatus: newsaveCityStatus ?? saveCityStatus,
      getCityStatus: newgetCityStatus ?? getCityStatus ,
      getAllCityStatus: newGetAllCityStatus ?? getAllCityStatus,
      deleteCityStatus: newDeleteCityStatus ?? deleteCityStatus,
    );
  }

  @override
  List<Object?> get props => [getCityStatus, saveCityStatus ,  getAllCityStatus,
    deleteCityStatus];
}
