import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/widgets/bottomnav.dart';

void main() {
  testWidgets(
    "click IconButton in bottom nav should moving to page 0 in pageview ",
    (tester) async {
      PageController pageController = PageController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: Bottomnav(pageController: pageController),
            body: PageView(
              controller: pageController,
              children: [Container(), Container()],
            ),
          ),
        ),
      );

      await tester.tap(find.widgetWithIcon(IconButton, Icons.home));

      await tester.pumpAndSettle();

      expect(pageController.page, 0);
    },
  );

   testWidgets(
    "click IconButton in bottom nav should moving to page 1 in pageview ",
    (tester) async {
      PageController pageController = PageController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: Bottomnav(pageController: pageController),
            body: PageView(
              controller: pageController,
              children: [Container(), Container()],
            ),
          ),
        ),
      );

      await tester.tap(find.widgetWithIcon(IconButton, Icons.bookmark));

      await tester.pumpAndSettle();

      expect(pageController.page, 1);
    },
  );
}
