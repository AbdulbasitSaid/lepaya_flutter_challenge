import 'dart:convert';
import 'dart:io';

import 'package:flutter_assignment/data_layer/models/hot/hot_model.dart';
import 'package:flutter_assignment/data_layer/models/new/new_model.dart';
import 'package:flutter_assignment/data_layer/models/rising/rising_model.dart';
import 'package:http/http.dart' as http;

class NotFoundException implements Exception {}

class RedditApiClient {
  final http.Client _httpClient;

  RedditApiClient({required http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final String baseUrl = 'https://www.reddit.com';

  Future<HotModel> fetchHotListing({int limit = 10, String? after}) async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/r/FlutterDev/hot.json?limit=$limit&after=$after'),
      );

      if (response.statusCode == 404) {
        throw NotFoundException();
      }

      return HotModel.fromJson(json.decode(response.body));
    } on SocketException {
      throw const SocketException('network error');
    }
  }

  Future<NewModel> fetchNewListing({int limit = 10, String? after}) async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$baseUrl/r/FlutterDev/new.json?limit=$limit&after=$after'),
      );

      if (response.statusCode == 404) {
        throw NotFoundException();
      }

      return NewModel.fromJson(json.decode(response.body));
    } on SocketException {
      throw const SocketException('network error');
    }
  }

  Future<RisingModel> fetchRisingListing(
      {int limit = 10, String? after}) async {
    try {
      final response = await _httpClient.get(
        Uri.parse(
            '$baseUrl/r/FlutterDev/rising.json?limit=$limit&after=$after'),
      );

      if (response.statusCode == 404) {
        throw NotFoundException();
      }

      return RisingModel.fromJson(json.decode(response.body));
    } on SocketException {
      throw const SocketException('network error');
    }
  }
}
