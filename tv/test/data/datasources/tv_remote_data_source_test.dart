import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';


void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("get on air tv", () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air.json')))
        .tvList;

    test("seharusnya mengembalikan list of tv model ketika codenya 200",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
      //act
      final result = await dataSource.getNowPlayingTv();
      //assert
      expect(result, equals(tTvList));
    });

    test(
        "seharusnya mengembalikan server exception ketika codenya 404 atau yg lainnya",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getNowPlayingTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group("get popular tv", () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air.json')))
        .tvList;

    test("seharusnya mengembalikan list of tv model ketika codenya 200",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
      //act
      final result = await dataSource.getPopularTv();
      //assert
      expect(result, equals(tTvList));
    });

    test(
        "seharusnya mengembalikan server exception ketika codenya 404 atau yg lainnya",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getPopularTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group("get top rate tv", () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air.json')))
        .tvList;

    test("seharusnya mengembalikan list of tv model ketika codenya 200",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
      //act
      final result = await dataSource.getTopRatedTv();
      //assert
      expect(result, equals(tTvList));
    });

    test(
        "seharusnya mengembalikan server exception ketika codenya 404 atau yg lainnya",
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTopRatedTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tMovieDetail = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('seharusnya mengembalikan tv model ketika status code 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('seharusnya melempar exception ketika code bukan 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tMovieList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('seharusnya mengembalikan list tv ketika status code 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'seharusnya mengemnbalikan server exception ketika stattus code bukan 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/search_game_of_thrones.json')))
        .tvList;
    final tQuery = 'Game';

    test('seharusnya mengembalikan list tv ketika status code 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_game_of_thrones.json'), 200));
      // act
      final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test(
        'seharusnya mengembalikan serverexception ketika status code bukan 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTv(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
