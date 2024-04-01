import 'package:flutter_assignment/data_layer/reddit_api_client.dart';
import 'package:flutter_assignment/domain_layer/reddit_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<http.Client>(() => http.Client());

  getItInstance.registerLazySingleton<RedditApiClient>(
      () => RedditApiClient(httpClient: getItInstance()));
  getItInstance.registerLazySingleton<RedditRepository>(
      () => RedditRepository(redditApiClient: getItInstance()));
}
