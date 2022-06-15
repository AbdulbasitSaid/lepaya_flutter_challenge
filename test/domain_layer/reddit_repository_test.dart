import 'package:flutter_assignment/data_layer/models/hot/hot_model.dart';
import 'package:flutter_assignment/data_layer/models/new/new_model.dart';
import 'package:flutter_assignment/data_layer/models/rising/rising_model.dart';
import 'package:flutter_assignment/data_layer/reddit_api_client.dart';
import 'package:flutter_assignment/domain_layer/reddit_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  late String sampleData;
  late MockClient successClient;
  late MockClient notFoundClient;
  setUp(() {
    successClient = MockClient((request) async => Response(sampleData, 200));
    notFoundClient = MockClient((request) async => Response('', 404, headers: {
          'content-type': 'application/json',
        }));
  });

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
  group('Hot listing', () {
    test('get correct hot listing', () async {
      final redditApiClient = RedditApiClient(httpClient: successClient);
      final redditRepository =
          RedditRepository(redditApiClient: redditApiClient);
      final result = await redditRepository.getHotListing();
      expect(result, isA<HotModel>());
    });
    test('should through not found exception', () async {
      final redditApiClient = RedditApiClient(httpClient: notFoundClient);
      final redditRepository =
          RedditRepository(redditApiClient: redditApiClient);
      expectLater(
          redditRepository.getHotListing(), throwsA(isA<NotFoundException>()));
    });
  });
  group('New listing', () {
    test('get correct new listing', () async {
      final redditApiClient = RedditApiClient(httpClient: successClient);
      final redditRepository =
          RedditRepository(redditApiClient: redditApiClient);
      final result = await redditRepository.getNewListing();
      expect(result, isA<NewModel>());
    });
    test('should through not found exception', () async {
      final redditApiClient = RedditApiClient(httpClient: notFoundClient);
      final redditRepository =
          RedditRepository(redditApiClient: redditApiClient);
      expectLater(
          redditRepository.getNewListing(), throwsA(isA<NotFoundException>()));
    });
  });
  group('Rising listing', () {
    test('get rising new listing', () async {
      final redditApiClient = RedditApiClient(httpClient: successClient);
      final redditRepository =
          RedditRepository(redditApiClient: redditApiClient);
      final result = await redditRepository.getRisingListing();
      expect(result, isA<RisingModel>());
    });
    test('should through not found exception', () async {
      final redditApiClient = RedditApiClient(httpClient: notFoundClient);
      final redditRepository =
          RedditRepository(redditApiClient: redditApiClient);
      expectLater(redditRepository.getRisingListing(),
          throwsA(isA<NotFoundException>()));
    });
  });
}
