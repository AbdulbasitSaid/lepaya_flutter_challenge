import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_assignment/application_layer/models/listing_view_model.dart';
import 'package:flutter_assignment/application_layer/new/bloc/new_bloc.dart';
import 'package:flutter_assignment/data_layer/reddit_api_client.dart';
import 'package:flutter_assignment/domain_layer/reddit_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group('New bloc', () {
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

    blocTest<NewBloc, NewState>(
        'emits [initial, success] when getNewLising returns NewModel',
        build: () => NewBloc(redditRepository: successRepository),
        act: (bloc) => bloc.add(NewListingFetched()),
        expect: () => <NewState>[
              const NewState(
                status: NewLisitingStatus.success,
                hasReachedMax: false,
                message: '',
                posts: [
                  ListingViewModel(
                    title: 'title',
                    postConent: 'title',
                    id: 'name',
                    postUrl: 'permalink',
                  ),
                ],
              ),
            ]);

    blocTest<NewBloc, NewState>(
        'emits [initial, failure] when getNewLising returns failue',
        build: () => NewBloc(redditRepository: failedRepository),
        act: (bloc) => bloc.add(NewListingFetched()),
        expect: () => <NewState>[
              const NewState(
                status: NewLisitingStatus.failure,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
            ]);
    blocTest<NewBloc, NewState>(
        'emits [initial, success] when refereshing returns NewModel',
        build: () => NewBloc(redditRepository: successRepository),
        act: (bloc) => bloc.add(NewListingRefereshed()),
        expect: () => <NewState>[
              const NewState(
                status: NewLisitingStatus.initail,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
              const NewState(
                status: NewLisitingStatus.success,
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

    blocTest<NewBloc, NewState>(
        'emits [initial, failed] when refereshing returns NewModel',
        build: () => NewBloc(redditRepository: failedRepository),
        act: (bloc) => bloc.add(NewListingRefereshed()),
        expect: () => <NewState>[
              const NewState(
                status: NewLisitingStatus.initail,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
              const NewState(
                status: NewLisitingStatus.failure,
                hasReachedMax: false,
                message: '',
                posts: [],
              ),
            ]);
 
 
  });
}
