import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:youtap/configs/config.dart';
import 'package:youtap/model/movie/movie_detail.dart';
import 'package:youtap/model/movie/movie_reviews.dart';
import 'package:youtap/model/movie/now_playing_movies.dart';
import 'package:youtap/model/movie/popular_movies.dart';
import 'package:youtap/model/tv/tv_detail.dart';
import 'package:youtap/model/tv/tv_on_the_air.dart';
import 'package:youtap/model/tv/tv_popular.dart';
import 'package:youtap/model/tv/tv_reviews.dart';

import '../model/movie/upcoming_movies.dart';

@Singleton()
class APIRequest {
  String baseUrl = Config.baseURL;
  String apiKey = Config.apiKey;

  Future<UpcomingMovies> getUpcomingMovies(int page) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'movie/upcoming?api_key=$apiKey&page=$page'))
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      UpcomingMovies upcomingMovies = UpcomingMovies.fromJson(json.decode(response.body));
      return upcomingMovies;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<NowPlayingMovies> getNowPlayingMovies(int page) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'movie/now_playing?api_key=$apiKey&page=$page'))
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      NowPlayingMovies nowPlayingMovies = NowPlayingMovies.fromJson(json.decode(response.body));
      return nowPlayingMovies;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<PopularMovies> getPopularMovies(int page) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'movie/upcoming?api_key=$apiKey&page=$page'))
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      PopularMovies popularMovies = PopularMovies.fromJson(json.decode(response.body));
      return popularMovies;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<MovieDetail> getMovieDetail(int id) async {
    final response = await http.get(Uri.parse(baseUrl + 'movie/$id?api_key=$apiKey')).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      MovieDetail movieDetail = MovieDetail.fromJson(json.decode(response.body));
      return movieDetail;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<MovieReviews> getMovieReviews(int id, int page) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'movie/$id/reviews?api_key=$apiKey&page=$page'))
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      MovieReviews movieReviews = MovieReviews.fromJson(json.decode(response.body));
      return movieReviews;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<TVOnTheAir> getTVOnTheAir(int page) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'tv/on_the_air?api_key=$apiKey&page=$page'))
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      TVOnTheAir tvOnTheAir = TVOnTheAir.fromJson(json.decode(response.body));
      return tvOnTheAir;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<TVPopular> getTVPopular(int page) async {
    final response =
        await http.get(Uri.parse(baseUrl + 'tv/popular?api_key=$apiKey')).timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      TVPopular tvPopular = TVPopular.fromJson(json.decode(response.body));
      return tvPopular;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<TVDetail> getTVDetail(int id) async {
    final response = await http.get(Uri.parse(baseUrl + 'tv/$id?api_key=$apiKey')).timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      TVDetail tvDetail = TVDetail.fromJson(json.decode(response.body));
      return tvDetail;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }

  Future<TVReviews> getTVReviews(int id, int page) async {
    final response = await http
        .get(Uri.parse(baseUrl + 'tv/$id/reviews?api_key=$apiKey&page=$page'))
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      TVReviews tvReviews = TVReviews.fromJson(json.decode(response.body));
      return tvReviews;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.statusCode.toString());
    }
  }
}
