import 'package:injectable/injectable.dart';
import 'package:youtap/bloc/movies/movie_detail_bloc.dart';
import 'package:youtap/bloc/movies/movie_reviews_bloc.dart';
import 'package:youtap/bloc/movies/now_playing_movies_bloc.dart';
import 'package:youtap/bloc/movies/popular_movies_bloc.dart';
import 'package:youtap/bloc/movies/upcoming_movies_bloc.dart';
import 'package:youtap/bloc/tv/tv_detail_bloc.dart';
import 'package:youtap/bloc/tv/tv_on_the_air_bloc.dart';
import 'package:youtap/bloc/tv/tv_popular_bloc.dart';
import 'package:youtap/bloc/tv/tv_reviews_bloc.dart';
import 'package:youtap/injections/injection.dart';

@Singleton()
class Bloc {
  //movies
  UpcomingMoviesBloc upcomingMoviesBloc = UpcomingMoviesBloc();
  PopularMoviesBloc popularMoviesBloc = PopularMoviesBloc();
  NPMoviesBloc npMoviesBloc = NPMoviesBloc();
  MovieDetailBloc movieDetailBloc = MovieDetailBloc();
  MovieReviewsBloc movieReviewsBloc = MovieReviewsBloc();

  //tv
  TVOnTheAirBloc tvOnTheAirBloc = TVOnTheAirBloc();
  TVPopularBloc tvPopularBloc = TVPopularBloc();
  TVDetailBloc tvDetailBloc = TVDetailBloc();
  TVReviewsBloc tvReviewsBloc = TVReviewsBloc();
}
