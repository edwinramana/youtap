import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/tv/tv_detail.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class TVDetailBloc {
  final _tvDetailFetcher = PublishSubject<TVDetail>();

  Stream<TVDetail> get tvDetail => _tvDetailFetcher.stream;

  getTVDetail(int id) async {
    String error = "";
    getIt<APIRequest>().getTVDetail(id).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _tvDetailFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _tvDetailFetcher.sink.add(value);
    });
  }

  disposeNetwork() {
    _tvDetailFetcher.close();
  }
}
