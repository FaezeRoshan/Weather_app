import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/utils/data_converter.dart';

void main() {
  test("should be return ---Jan---", () {
    var result = DateConverter.monthNumberToName(1);
    expect(result, "Jan");
  });

  test("should be return ---10:39 AM---", () {
    var result = DateConverter.changeDtToDateTimeHour("166012786", 0);
    expect(result, "10:39 AM");
  });
}
