import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/widgets/main_wrapper.dart';
import 'package:weather/features/feature_bookmark/presentation/bloc/bloc/book_mark_bloc.dart';
import 'package:weather/features/feature_weather/presentation/bloc/bloc/bloc_weather_bloc.dart';
import 'package:weather/locator/locator.dart';

Future<void> main() async {
 await setup();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiRepositoryProvider(
      providers: [
       BlocProvider(create:(_) =>locator<BlocWeatherBloc>()),
      BlocProvider(create: (_) => locator<BookMarkBloc>()),
      ],
      child: MainWrapper(),
    ),
  ));
}

