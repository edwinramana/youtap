import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/movie/movie_reviews.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class MovieReviewsBloc {
  final _movieReviewsFetcher = PublishSubject<MovieReviews>();
  int page = 2;
  late MovieReviews _movieReviews;
  Stream<MovieReviews> get movieReviews => _movieReviewsFetcher.stream;

  getMovieReviews(int id) async {
    String error = "";
    getIt<APIRequest>().getMovieReviews(id, 1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _movieReviewsFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _movieReviews = value;
      _movieReviewsFetcher.sink.add(value);
    });
  }

  loadMoreMovieReviews(int id) async {
    String error = "";
    if(page<=_movieReviews.totalPages!){
      getIt<APIRequest>().getMovieReviews(id, page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _movieReviewsFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        _movieReviews.results!.addAll(value.results!);
        _movieReviewsFetcher.sink.add(_movieReviews);
      });
    }

  }

  disposeNetwork() {
    _movieReviewsFetcher.close();
  }
}
