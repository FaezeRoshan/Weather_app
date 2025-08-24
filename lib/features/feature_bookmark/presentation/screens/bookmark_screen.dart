import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/book_mark_bloc.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/get_all_city_status.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/bloc_weather_bloc.dart';

class BookmarkScreen extends StatelessWidget {
  final PageController pageController;
  const BookmarkScreen({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    BlocProvider.of<BookMarkBloc>(context).add(GetAllCityEvent());
    return BlocBuilder<BookMarkBloc, BookMarkState>(
      buildWhen: (previous, current) {
        if (previous.getAllCityStatus == current.getAllCityStatus) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state.getAllCityStatus is GetAllCityLoading) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: Colors.white,
              size: 50,
            ),
          );
        }
        if (state.getAllCityStatus is GetAllCityError) {
          GetAllCityError getAllCityError =
              state.getAllCityStatus as GetAllCityError;
          return Center(child: Text(getAllCityError.error!));
        }

        if (state.getAllCityStatus is GetAllCityCompleted) {
          GetAllCityCompleted getAllCityCompleted =
              state.getAllCityStatus as GetAllCityCompleted;
          List<City> cities = getAllCityCompleted.cities;
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "WatchList",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child:
                      (cities.isEmpty)
                          ? Center(
                            child: Text(
                              "there is no bookmark city",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                          : ListView.builder(
                            itemCount: cities.length,
                            itemBuilder: (context, index) {
                              City city = cities[index];
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<BlocWeatherBloc>(
                                    context,
                                  ).add(LoadCwEvent(city.name));
                                  pageController.animateToPage(
                                    0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5.0,
                                        sigmaY: 5.0,
                                      ),
                                      child: Container(
                                        width: width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.grey.shade800,
                                        ),

                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,

                                            children: [
                                              Text(
                                                city.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<BookMarkBloc>(
                                                    context,
                                                  ).add(
                                                    DeleteCityEvent(city.name),
                                                  );
                                                  BlocProvider.of<BookMarkBloc>(
                                                    context,
                                                  ).add(GetAllCityEvent());
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
