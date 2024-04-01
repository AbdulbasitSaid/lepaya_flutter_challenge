import 'package:flutter_assignment/data_layer/models/hot/hot_model.dart';
import 'package:flutter_assignment/data_layer/models/new/new_model.dart';
import 'package:flutter_assignment/data_layer/models/rising/rising_model.dart';
import 'package:flutter_assignment/data_layer/reddit_api_client.dart';

class RedditRepository {
  final RedditApiClient redditApiClient;

  RedditRepository({required this.redditApiClient});

  Future<HotModel> getHotListing({String? after}) async {
    final result = await redditApiClient.fetchHotListing(after: after);
    return result;
  }

  Future<NewModel> getNewListing({String? after}) async {
    final result = await redditApiClient.fetchNewListing(after: after);
    return result;
  }

  Future<RisingModel> getRisingListing({String? after}) async {
    final result = await redditApiClient.fetchRisingListing(after: after);
    return result;
  }
}
