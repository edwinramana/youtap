import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/tv/tv_reviews.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class TVReviewsBloc {
  final _tvReviewsFetcher = PublishSubject<TVReviews>();
  int page=2;
  late TVReviews _tvReviews;
  Stream<TVReviews> get tvReviewsList => _tvReviewsFetcher.stream;

  getTVReviews(int id) async {
    String error = "";
    getIt<APIRequest>().getTVReviews(id, 1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _tvReviewsFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _tvReviewsFetcher.sink.add(value);
    });
  }

  loadMoreTVReviews(int id) async {
    String error = "";
    if(page<=_tvReviews.totalPages!){
      getIt<APIRequest>().getTVReviews(id, page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _tvReviewsFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        page++;
        _tvReviews.results!.addAll(value.results!);
        _tvReviewsFetcher.sink.add(_tvReviews);
      });
    }

  }


  disposeNetwork() {
    _tvReviewsFetcher.close();
  }
}
