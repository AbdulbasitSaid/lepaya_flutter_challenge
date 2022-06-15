import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_assignment/application_layer/models/listing_view_model.dart';
import 'package:flutter_assignment/application_layer/rising/bloc/rising_bloc.dart';
import 'package:flutter_assignment/data_layer/reddit_api_client.dart';
import 'package:flutter_assignment/domain_layer/reddit_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group('Rising bloc', () {
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

    blocTest<RisingBloc, RisingState>(
        'emits [initial, success] when getHotLising returns HotModel',
        build: () => RisingBloc(redditRepository: successRepository),
        act: (bloc) => bloc.add(RisingListingFetched()),
        expect: () => <RisingState>[
              const RisingState(
                status: RisingLisitingStatus.success,
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
    blocTest<RisingBloc, RisingState>(
        'emits [initial, failure] when getHotLising returns failue',
        build: () => RisingBloc(redditRepository: failedRepository),
        act: (bloc) => bloc.add(RisingListingFetched()),
        expect: () => <RisingState>[
              const RisingState(
                status: RisingLisitingStatus.failure,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
            ]);
    blocTest<RisingBloc, RisingState>(
        'emits [initial, success] when refereshing returns RisingModel',
        build: () => RisingBloc(redditRepository: successRepository),
        act: (bloc) => bloc.add(RisingListingRefereshed()),
        expect: () => <RisingState>[
              const RisingState(
                status: RisingLisitingStatus.initail,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
              const RisingState(
                status: RisingLisitingStatus.success,
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

    blocTest<RisingBloc, RisingState>(
        'emits [initial, failed] when refereshing returns RisingModel',
        build: () => RisingBloc(redditRepository: failedRepository),
        act: (bloc) => bloc.add(RisingListingRefereshed()),
        expect: () => <RisingState>[
              const RisingState(
                status: RisingLisitingStatus.initail,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
              const RisingState(
                status: RisingLisitingStatus.failure,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
            ]);
  });
}
