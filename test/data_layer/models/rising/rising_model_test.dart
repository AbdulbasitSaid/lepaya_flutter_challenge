import 'package:flutter_assignment/data_layer/models/rising/rising_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Rising model', () {
    late dynamic sampleData;
    setUp(() {
      sampleData = {
        "data": {
          "after": "t3_v5h03f",
          "dist": 1,
          "children": [
            {
              "data": {
                "selftext": "",
                "title":
                    "One of the best State Management explanations I've seen for beginners (State Management for minimalists, code included)",
                "name": "t3_v5h03f",
                "permalink":
                    "/r/FlutterDev/comments/v5h03f/one_of_the_best_state_management_explanations_ive/",
                "url":
                    "https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1"
              }
            }
          ]
        }
      };
    });
    test(
        'Risign model should have fromJson function that returns Rising and must have data',
        () {
      final result = RisingModel.fromJson(sampleData);
      expect(
          result,
          isA<RisingModel>().having(
            (p0) => p0.data,
            'should not be null',
            isNotNull,
          ));
    });
  });
}
