import 'package:flutter_assignment/data_layer/models/hot/hot_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hot model', () {
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
        'Hot model should have fromJson function that returns HotModel and must have data',
        () {
      final result = HotModel.fromJson(sampleData);
      expect(
          result,
          isA<HotModel>().having(
            (p0) => p0.data,
            'should not be null',
            isNotNull,
          ));
    });
  });
}
