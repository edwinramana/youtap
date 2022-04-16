import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/movie/popular_movies.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';
class PopularMoviesBloc {
  final _popularMoviesFetcher = PublishSubject<PopularMovies>();
  late PopularMovies _popularMovies;
  int page = 2;
  Stream<PopularMovies> get popularMovieList => _popularMoviesFetcher.stream;

  getPopularMovies() async {
    String error = "";
    getIt<APIRequest>().getPopularMovies(1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _popularMoviesFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _popularMovies = value;
      _popularMoviesFetcher.sink.add(value);
    });
  }

  loadMorePopularMovies() async {
    String error;
    if(page<=_popularMovies.totalPages!) {
      getIt<APIRequest>().getPopularMovies(page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _popularMoviesFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        page++;
        _popularMovies.results!.addAll(value.results!);
        _popularMoviesFetcher.sink.add(_popularMovies);
      });
    }
  }


  disposeNetwork() {
    _popularMoviesFetcher.close();
  }
}
