import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather/core/params/forecast_params.dart';
import 'package:weather/core/utils/data_converter.dart';
import 'package:weather/core/widgets/app_background.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/book_mark_bloc.dart';
import 'package:weather/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:weather/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather/features/feature_weather/domain/use_cases/get_suggest_usecase.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/bloc_weather_bloc.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/cw_status.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/fw_status.dart';
import 'package:weather/features/feature_weather/presentation/widgets/bookmark_icon.dart';
import 'package:weather/features/feature_weather/presentation/widgets/day_weather_view.dart';
import 'package:weather/locator/locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  String cityName = "Tehran";
  TextEditingController textEditingController = TextEditingController();
  GetSuggestUsecase getSuggestUsecase = GetSuggestUsecase(locator());
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocWeatherBloc>(context).add(LoadCwEvent(cityName));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height * .02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .03),
            child: Row(
              children: [
                Expanded(
                  child: TypeAheadField(
                    controller: textEditingController,
                    builder: (context, controller, focusNode) {
                      return TextField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter a City...",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    decorationBuilder: (context, child) {
                      return Material(
                        type: MaterialType.card,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        surfaceTintColor: const Color.fromRGBO(255, 193, 7, 1),
                        child: child,
                      );
                    },
                    itemBuilder: (context, value) {
                      return ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(value.name!),
                        subtitle: Text("${value.region} ${value.country}"),
                      );
                    },
                    onSelected: (value) {
                      textEditingController.text = value.name!;
                      BlocProvider.of<BlocWeatherBloc>(
                        context,
                      ).add(LoadCwEvent(value.name!));
                      textEditingController.clear();
                    },
                    suggestionsCallback: (search) {
                      return getSuggestUsecase(search);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<BlocWeatherBloc, BlocWeatherState>(
                  buildWhen: (previous, current) {
                    if (previous.cwStatus == current.cwStatus) {
                      return false;
                    }
                    return true;
                  },

                  builder: (context, state) {
                    if (state.cwStatus is CwLoading) {
                      return LoadingAnimationWidget.dotsTriangle(
                        color: Colors.white,
                        size: 25,
                      );
                    }
                    if (state.cwStatus is CwCompleted) {
                      final CwCompleted cwCompleted =
                          state.cwStatus as CwCompleted;
                      BlocProvider.of<BookMarkBloc>(context).add(
                        GetCityByNameEvent(cwCompleted.currentCityEntity.name!),
                      );
                      return BookmarkIcon(
                        name: cwCompleted.currentCityEntity.name!,
                      );
                    }

                    if (state.cwStatus is CwError) {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.error, color: Colors.white, size: 25),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),

          BlocBuilder<BlocWeatherBloc, BlocWeatherState>(
            buildWhen: (previous, current) {
              if (previous.cwStatus == current.cwStatus) {
                return false;
              }
              return true;
            },
            builder: (context, state) {
              if (state.cwStatus is CwLoading) {
                return SizedBox(
                  height: 350,
                  child: Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                );
              }

              if (state.cwStatus is CwCompleted) {
                final CwCompleted cwComplected = state.cwStatus as CwCompleted;
                final CurrentCityEntity currentCityEntity =
                    cwComplected.currentCityEntity;

                final ForecastParams forecastParams = ForecastParams(
                  currentCityEntity.coord!.lat,
                  currentCityEntity.coord!.lon,
                );
                BlocProvider.of<BlocWeatherBloc>(
                  context,
                ).add(LoadFwEvent(forecastParams));
                final sunrise = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunrise,
                  currentCityEntity.timezone,
                );
                final sunset = DateConverter.changeDtToDateTimeHour(
                  currentCityEntity.sys!.sunset,
                  currentCityEntity.timezone,
                );
                return Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height * .02),
                        child: SizedBox(
                          width: width,
                          height: 380,
                          child: PageView.builder(
                            allowImplicitScrolling: true,
                            itemCount: 2,
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 50),
                                      child: Text(
                                        currentCityEntity.name!,
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        currentCityEntity
                                            .weather![0]
                                            .description,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: AppBackground.setIconForMain(
                                        currentCityEntity
                                            .weather![0]
                                            .description,
                                        height * .1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        "${currentCityEntity.main!.temp.round()}\u00B0",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Max",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "${currentCityEntity.main!.tempMax.round()}\u00B0",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Container(
                                            width: 2,
                                            height: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Min",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "${currentCityEntity.main!.tempMin.round()}\u00B0",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Container(color: Colors.amber);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 2,
                          onDotClicked: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          effect: ExpandingDotsEffect(
                            activeDotColor: Colors.white,
                            dotWidth: 10,
                            dotHeight: 10,
                            spacing: 5,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          color: Colors.white24,
                          height: 2,
                          width: double.infinity,
                        ),
                      ),

                      SizedBox(height: height * 0.01),

                      /// forecast weather 7 days
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.9),
                          child: Center(
                            child: BlocBuilder<
                              BlocWeatherBloc,
                              BlocWeatherState
                            >(
                              builder: (BuildContext context, state) {
                                /// show Loading State for Fw
                                if (state.fwStatus is FwLoading) {
                                  return Center(
                                    child: LoadingAnimationWidget.dotsTriangle(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  );
                                }

                                /// show Completed State for Fw
                                if (state.fwStatus is FwCompleted) {
                                  /// casting
                                  final FwCompleted fwCompleted =
                                      state.fwStatus as FwCompleted;
                                  final ForecastDaysEntity forecastDaysEntity =
                                      fwCompleted.forecastDaysEntity;
                                  final Daily? mainDaily =
                                      forecastDaysEntity.daily;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: mainDaily!.time.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return DaysWeatherView(
                                        index: index,
                                        mainDaily: mainDaily,
                                      );
                                    },
                                  );
                                }

                                /// show Error State for Fw
                                if (state.fwStatus is FwError) {
                                  final FwError fwError =
                                      state.fwStatus as FwError;
                                  return Center(
                                    child: Text(
                                      fwError.error,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                /// show Default State for Fw
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          color: Colors.white24,
                          height: 2,
                          width: double.infinity,
                        ),
                      ),

                      SizedBox(height: 30),

                      /// last Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "wind speed",
                                style: TextStyle(
                                  fontSize: height * 0.021,
                                  color: Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "${currentCityEntity.wind!.speed} m/s",
                                  style: TextStyle(
                                    fontSize: height * 0.02,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              color: Colors.white24,
                              height: 30,
                              width: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text(
                                  "sunrise",
                                  style: TextStyle(
                                    fontSize: height * 0.021,
                                    color: Colors.amber,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    sunrise,
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              color: Colors.white24,
                              height: 30,
                              width: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text(
                                  "sunset",
                                  style: TextStyle(
                                    fontSize: height * 0.021,
                                    color: Colors.amber,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    sunset,
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              color: Colors.white24,
                              height: 30,
                              width: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text(
                                  "humidity",
                                  style: TextStyle(
                                    fontSize: height * 0.021,
                                    color: Colors.amber,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "${currentCityEntity.main!.humidity}%",
                                    style: TextStyle(
                                      fontSize: height * 0.02,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                );
              }
              if (state.cwStatus is CwError) {
                final CwError cwError = state.cwStatus as CwError;
                return SizedBox(
                  height: 350,
                  child: Center(
                    child: Text(
                      cwError.error,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
  
  @override
  
  bool get wantKeepAlive => true;
}
