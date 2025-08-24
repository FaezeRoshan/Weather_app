import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/book_mark_bloc.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_city_status.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/save_city_status.dart';

class BookmarkIcon extends StatelessWidget {
  final String name;
  const BookmarkIcon({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookMarkBloc, BookMarkState>(
      buildWhen: (previous, current) {
        if (previous.getCityStatus == current.getCityStatus) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        BlocProvider.of<BookMarkBloc>(context).add(SaveCityInitialEvent());

        if (state.getCityStatus is GetCityLoading) {
          return LoadingAnimationWidget.dotsTriangle(
            color: Colors.white,
            size: 25,
          );
        }

        if (state.getCityStatus is GetCityCompleted) {
          GetCityCompleted getCityCompleted =
              state.getCityStatus as GetCityCompleted;
          City? city = getCityCompleted.city;
          return BlocConsumer<BookMarkBloc, BookMarkState>(
            listenWhen: (previous, current) {
              if (previous.saveCityStatus == current.saveCityStatus) {
                return false;
              }
              return true;
            },
            buildWhen: (previous, current) {
              if (previous.saveCityStatus == current.saveCityStatus) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state.saveCityStatus is SaveCityError) {
                SaveCityError saveCityError = state.saveCityStatus as SaveCityError;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(saveCityError.error!),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              if (state.saveCityStatus is SaveCityCompeleted) {
                SaveCityCompeleted saveCityCompeleted =
                    state.saveCityStatus as SaveCityCompeleted;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${saveCityCompeleted.city.name} Added to Bookmark",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state.saveCityStatus is SaveCityInitial) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<BookMarkBloc>(
                      context,
                    ).add(SaveCwEvent(name));
                  },
                  icon: Icon(
                    city == null ? Icons.star_border : Icons.star,
                    color: Colors.white,
                    size: 30,
                  ),
                );
              }
              if (state.getCityStatus is GetCityError) {
                return IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("please load a city!"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.error, color: Colors.white, size: 30),
                );
              }

              if (state.saveCityStatus is SaveCityLoading) {
                return LoadingAnimationWidget.dotsTriangle(
                  color: Colors.white,
                  size: 25,
                );
              }
              return IconButton(
                onPressed: () {
                 BlocProvider.of<BookMarkBloc>(context).add(SaveCwEvent(name));
                },
                icon: Icon(Icons.star, color: Colors.white, size: 30),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
