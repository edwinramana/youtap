import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/movie/upcoming_movies.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class UpcomingMoviesBloc {
  final _upMoviesFetcher = PublishSubject<UpcomingMovies>();
  final _test = PublishSubject<int>();
  int page = 2;
  late UpcomingMovies _upcomingMovies;
  Stream<UpcomingMovies> get upMovieList => _upMoviesFetcher.stream;

  getUpcomingMovies() async {
    String error = "";
    getIt<APIRequest>().getUpcomingMovies(1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _upMoviesFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _upMoviesFetcher.sink.add(value);
    });
  }

  loadMoreUpcomingMovies() async {
    String error;
    if(page<=_upcomingMovies.totalPages!) {
      getIt<APIRequest>().getUpcomingMovies(page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _upMoviesFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        page++;
        _upcomingMovies.results!.addAll(value.results!);
        _upMoviesFetcher.sink.add(_upcomingMovies);
      });
    }
  }

  disposeNetwork() {
    _upMoviesFetcher.close();
  }
}
