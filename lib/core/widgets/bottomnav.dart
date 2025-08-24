import 'package:flutter/material.dart';

class Bottomnav extends StatelessWidget {
  final PageController pageController;

  const Bottomnav({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.home),
            ),
            IconButton(onPressed: () {
               pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInQuad,
                );
            }, icon: Icon(Icons.bookmark)),
          ],
        ),
      ),
    );
  }
}
