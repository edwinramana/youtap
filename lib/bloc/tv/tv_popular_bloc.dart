import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/tv/tv_popular.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class TVPopularBloc {
  final _popularTVFetcher = PublishSubject<TVPopular>();
  int page = 2;
  late TVPopular _tvPopular;
  Stream<TVPopular> get tvPopularList => _popularTVFetcher.stream;

  getTVPopular() async {
    String error = "";
    getIt<APIRequest>().getTVPopular(1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _popularTVFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _popularTVFetcher.sink.add(value);
    });
  }

  loadMoreTVPopular() async {
    String error;
    if(page<=_tvPopular.totalPages!) {
      getIt<APIRequest>().getTVPopular(page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _popularTVFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        page++;
        _tvPopular.results!.addAll(value.results!);
        _popularTVFetcher.sink.add(_tvPopular);
      });
    }
  }

  disposeNetwork() {
    _popularTVFetcher.close();
  }
}
