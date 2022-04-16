import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';
import '../../model/movie/now_playing_movies.dart';

class NPMoviesBloc {
  final _npMoviesFetcher = PublishSubject<NowPlayingMovies>();
  late NowPlayingMovies _nowPlayingMovies;
  int page = 2;
  Stream<NowPlayingMovies> get npMovieList => _npMoviesFetcher.stream;

  getNowPlayingMovies() async {
    String error = "";
    getIt<APIRequest>().getNowPlayingMovies(1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _npMoviesFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _nowPlayingMovies = value;
      _npMoviesFetcher.sink.add(value);
    });
  }

  loadMoreNowPlayingMovies() async {
    String error;
    if(page<=_nowPlayingMovies.totalPages!){
      getIt<APIRequest>().getNowPlayingMovies(page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _npMoviesFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        page++;
        _nowPlayingMovies.results!.addAll(value.results!);
        _npMoviesFetcher.sink.add(_nowPlayingMovies);
      });
    }

  }




  disposeNetwork() {
    _npMoviesFetcher.close();
  }
}
