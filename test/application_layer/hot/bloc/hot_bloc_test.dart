import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_assignment/application_layer/hot/bloc/hot_bloc.dart';
import 'package:flutter_assignment/application_layer/models/listing_view_model.dart';
import 'package:flutter_assignment/data_layer/reddit_api_client.dart';
import 'package:flutter_assignment/domain_layer/reddit_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group('Hot block', () {
    late String sampleResponseBody;
    late MockClient successClient;
    late MockClient failureClient;
    late RedditApiClient successfulRedditApiClient;
    late RedditApiClient failedRedditApiClient;
    late RedditRepository successRepository;
    late RedditRepository failedRepository;
    setUpAll(() {
      sampleResponseBody = '''{
        "data": {
          "after": "after",
          "dist": 1,
          "children": [
            {
              "data": {
                "selftext": "",
                "title":
                    "title",
                "name": "name",
                "permalink":
                    "permalink",
                "url":
                    "url"
              }
            }
          ]
        }
      }''';
    });
    setUp(() async {
      successClient = MockClient((request) async {
        return Response(sampleResponseBody, 200, headers: {
          'content-type': 'application/json',
        });
      });
      successfulRedditApiClient = RedditApiClient(httpClient: successClient);
      successRepository =
          RedditRepository(redditApiClient: successfulRedditApiClient);

      failureClient = MockClient((request) async {
        return Response('', 404, headers: {
          'content-type': 'application/json',
        });
      });
      failedRedditApiClient = RedditApiClient(httpClient: failureClient);
      failedRepository =
          RedditRepository(redditApiClient: failedRedditApiClient);
    });

    blocTest<HotBloc, HotState>(
        'emits [initial, success] when getHotLising returns HotModel',
        build: () => HotBloc(redditRepository: successRepository),
        act: (bloc) => bloc.add(HotListingFetched()),
        expect: () => <HotState>[
              const HotState(
                status: HotLisitingStatus.success,
                hasReachedMax: false,
                message: '',
                posts: [
                  ListingViewModel(
                    title: 'title',
                    postConent: 'title',
                    id: 'name',
                    postUrl: 'permalink',
                  )
                ],
              ),
            ]);
    blocTest<HotBloc, HotState>(
        'emits [initial, success] when refereshing returns HotModel',
        build: () => HotBloc(redditRepository: successRepository),
        act: (bloc) => bloc.add(HotListingRefereshed()),
        expect: () => <HotState>[
              const HotState(
                status: HotLisitingStatus.initail,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
              const HotState(
                status: HotLisitingStatus.success,
                hasReachedMax: false,
                message: '',
                posts: [
                  ListingViewModel(
                    title: 'title',
                    postConent: 'title',
                    id: 'name',
                    postUrl: 'permalink',
                  )
                ],
              ),
            ]);
    blocTest<HotBloc, HotState>(
        'emits [initial, failed] when refereshing returns HotModel',
        build: () => HotBloc(redditRepository: failedRepository),
        act: (bloc) => bloc.add(HotListingRefereshed()),
        expect: () => <HotState>[
              const HotState(
                status: HotLisitingStatus.initail,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
              const HotState(
                status: HotLisitingStatus.failure,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
            ]);
    blocTest<HotBloc, HotState>(
        'emits [initial, failure] when getHotLising returns failue',
        build: () => HotBloc(redditRepository: failedRepository),
        act: (bloc) => bloc.add(HotListingFetched()),
        expect: () => <HotState>[
              const HotState(
                status: HotLisitingStatus.failure,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
            ]);
  });
}
