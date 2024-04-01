import 'package:flutter_assignment/data_layer/models/hot/hot_model.dart';
import 'package:flutter_assignment/data_layer/models/new/new_model.dart';
import 'package:flutter_assignment/data_layer/models/rising/rising_model.dart';
import 'package:flutter_assignment/data_layer/reddit_api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  late dynamic sampleData;
  setUpAll(() {
    sampleData = '''{
    "data": {
        "after": "t3_v5h03f",
        "dist": 1,
        "children": [
            {
                "data": {
                    "selftext": "",
                    "title": "One of the best State Management explanations I've seen for beginners (State Management for minimalists, code included)",
                    "name": "t3_v5h03f",
                    "permalink": "/r/FlutterDev/comments/v5h03f/one_of_the_best_state_management_explanations_ive/",
                    "url": "https://suragch.medium.com/flutter-state-management-for-minimalists-4c71a2f2f0c1"
                }
            }
        ]
    }
}''';
  });
  setUp(() {});

  group('hot request', () {
    test('makes correct http request', () async {
      var mockHTTPClient = MockClient((request) async {
        return Response(sampleData, 200, headers: {
          'content-type': 'application/json',
        });
      });

      var redditClient = RedditApiClient(httpClient: mockHTTPClient);
      final result = await redditClient.fetchHotListing();
      expect(result, isA<HotModel>());
    });
    test('makes incorrect correct http request', () async {
      var mockHTTPClient = MockClient((request) async {
        return Response(sampleData, 404, headers: {
          'content-type': 'application/json',
        });
      });

      var redditClient = RedditApiClient(httpClient: mockHTTPClient);
      expect(() async => await redditClient.fetchHotListing(),
          throwsA(isA<NotFoundException>()));
    });
  });
  group('new request', () {
    test('makes correct http request', () async {
      var mockHTTPClient = MockClient((request) async {
        return Response(sampleData, 200, headers: {
          'content-type': 'application/json',
        });
      });

      var redditClient = RedditApiClient(httpClient: mockHTTPClient);
      final result = await redditClient.fetchNewListing();
      expect(result, isA<NewModel>());
    });
    test('makes incorrect correct http request', () async {
      var mockHTTPClient = MockClient((request) async {
        return Response(sampleData, 404, headers: {
          'content-type': 'application/json',
        });
      });

      var redditClient = RedditApiClient(httpClient: mockHTTPClient);
      expect(() async => await redditClient.fetchNewListing(),
          throwsA(isA<NotFoundException>()));
    });
  });

  group('rising request', () {
    test('makes correct http request', () async {
      var mockHTTPClient = MockClient((request) async {
        return Response(sampleData, 200, headers: {
          'content-type': 'application/json',
        });
      });

      var redditClient = RedditApiClient(httpClient: mockHTTPClient);
      final result = await redditClient.fetchRisingListing();
      expect(result, isA<RisingModel>());
    });
    test('makes incorrect correct http request', () async {
      var mockHTTPClient = MockClient((request) async {
        return Response(sampleData, 404, headers: {
          'content-type': 'application/json',
        });
      });

      var redditClient = RedditApiClient(httpClient: mockHTTPClient);
      expect(() async => await redditClient.fetchRisingListing(),
          throwsA(isA<NotFoundException>()));
    });
  });
}
