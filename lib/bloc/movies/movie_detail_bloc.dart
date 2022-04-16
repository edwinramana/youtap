import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/movie/movie_detail.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class MovieDetailBloc {
  final _movieDetailFetcher = PublishSubject<MovieDetail>();

  Stream<MovieDetail> get movieDetail => _movieDetailFetcher.stream;

  getMovieDetail(int id) async {
    String error = "";
    getIt<APIRequest>().getMovieDetail(id).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _movieDetailFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _movieDetailFetcher.sink.add(value);
    });
  }

  disposeNetwork() {
    _movieDetailFetcher.close();
  }
}
