import 'package:rxdart/rxdart.dart';
import 'package:youtap/model/tv/tv_on_the_air.dart';

import '../../data/api_request.dart';
import '../../injections/injection.dart';

class TVOnTheAirBloc {
  final _onTheAirTVFetcher = PublishSubject<TVOnTheAir>();
  int page = 2;
  late TVOnTheAir _tvOnTheAir;
  Stream<TVOnTheAir> get tvOnTheAirList => _onTheAirTVFetcher.stream;

  getTVOnTheAir() async {
    String error = "";
    getIt<APIRequest>().getTVOnTheAir(1).timeout(const Duration(seconds: 30)).catchError((e) {
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
      _onTheAirTVFetcher.sink.addError(error);

      throw error; //or even the same error
    }).then((value) {
      _onTheAirTVFetcher.sink.add(value);
    });
  }

  loadMoreTVOnTheAir() async {
    String error;
    if(page<=_tvOnTheAir.totalPages!) {
      getIt<APIRequest>().getTVOnTheAir(page).timeout(const Duration(seconds: 30)).catchError((e) {
        error = e.toString();
        if (e.toString().toLowerCase().contains("timeout")) {
          error = "timeout";
        }
        _onTheAirTVFetcher.sink.addError(error);

        throw error; //or even the same error
      }).then((value) {
        page++;
        _tvOnTheAir.results!.addAll(value.results!);
        _onTheAirTVFetcher.sink.add(_tvOnTheAir);
      });
    }
  }

  disposeNetwork() {
    _onTheAirTVFetcher.close();
  }
}
