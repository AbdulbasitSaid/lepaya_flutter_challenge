import 'package:flutter_assignment/data_layer/models/data/data_model.dart';
import 'package:flutter_assignment/data_layer/models/hot/hot_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  group('data model', () {
    test('Data model should contain after, dist, and children', () {
      final result = HotModel.fromJson(sampleData).data;
      expect(
        result,
        isA<DataModel>()
            .having((p0) => p0.after, 'after should not be null', isNotNull)
            .having(
              (p0) => p0.children,
              'children should not be empty',
              isNotEmpty,
            )
            .having(
              (p0) => p0.dist,
              'should not be null',
              isNotNull,
            )
            .having((p0) => p0.dist, 'must be an int variable', isA<int>()),
      );
    });
  });
}
