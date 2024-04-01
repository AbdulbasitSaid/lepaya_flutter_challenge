import 'package:flutter_assignment/data_layer/models/child_data/child_data_model.dart';
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

  group('child data model', () {
    test('should contain title, name, permalink, and url', () {
      final result = HotModel.fromJson(sampleData).data.children[0].data;
      expect(
          result,
          isA<ChildDataModel>()
              .having((p0) => p0.name, 'must have name', isNotNull)
              .having((p0) => p0.permalink, 'must have permalink', isNotNull)
              .having((p0) => p0.title, 'must have title', isNotNull)
              .having((p0) => p0.url, 'must have a url', isNotNull));
    });
    test('should always return a post content', () {
      final result = HotModel.fromJson(sampleData).data.children[0].data;

      expect(
          result,
          isA<ChildDataModel>()
              .having((p0) => p0.selftext, 'should be of String type',
                  isA<String>())
              .having((p0) => p0.selftext, 'expecting an empty string', isEmpty)
              .having((p0) => p0.getPostContent,
                  'should always return a post content', isNotNull));
    });
  });
}
