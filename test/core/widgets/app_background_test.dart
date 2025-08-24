import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/widgets/app_background.dart';

void main() {


  test('should return  __ pic_bg.jpg __Set the photo with your time', () {
    var result = AppBackground.getBackGroundImage();
    expect((result.assetName), "images/pic_bg.jpg");
  });

  test("should be return __cloud day icon__", () {
    var result = AppBackground.setIconForMain("few clouds", 5.0);
   expect((result.image as AssetImage).assetName, 'images/icons8-partly-cloudy-day-80.png' );
  });

  test(" should be return __ rain icon __", () {
    final result = AppBackground.SetIconForecast(3, 5.0);
    expect((result.image as AssetImage).assetName, 'images/icons8-partly-cloudy-day-80.png' );
  });
}
