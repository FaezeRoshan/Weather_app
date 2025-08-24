import 'package:flutter/material.dart';
import 'package:weather/core/widgets/app_background.dart';
import 'package:weather/core/widgets/bottomnav.dart';
import 'package:weather/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:weather/features/feature_weather/presentation/screens/home_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> PageViews = [HomeScreen(), BookmarkScreen(pageController: pageController,)];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Bottomnav(pageController: pageController,),
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(fit:BoxFit.cover,
            image: AppBackground.getBackGroundImage())
        ),
        height: size.height,
        child: PageView(
          controller: pageController,
          children: PageViews,
        ),
      ),
    );
  }
}
