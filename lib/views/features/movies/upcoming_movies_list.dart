import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtap/bloc/bloc.dart';
import 'package:youtap/model/movie/upcoming_movies.dart';
import 'package:youtap/views/pages/movies/movie_detail_page.dart';

import '../../../configs/config.dart';
import '../../../injections/injection.dart';
import '../../templates/loaders/color_loader_5.dart';

class UpcomingMoviesList extends StatefulWidget {
  const UpcomingMoviesList({Key? key}) : super(key: key);

  @override
  _UpcomingMoviesListState createState() => _UpcomingMoviesListState();
}

class _UpcomingMoviesListState extends State<UpcomingMoviesList> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getIt<Bloc>().upcomingMoviesBloc.getUpcomingMovies();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        getIt<Bloc>().upcomingMoviesBloc.loadMoreUpcomingMovies();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getIt<Bloc>().upcomingMoviesBloc.upMovieList,
      builder: (context, AsyncSnapshot<UpcomingMovies> snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
          return InkWell(
              child: const Center(child: Text("Error occured\n Please tap to retry!")),
              onTap: () => setState(() {
                    getIt<Bloc>().upcomingMoviesBloc.getUpcomingMovies();
                  }));
        } else if (snapshot.hasData) {
          return (snapshot.data!.results!.isEmpty)
              ? ListView(
                  children: const <Widget>[
                    Text(
                      "No data available",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return getIt<Bloc>().upcomingMoviesBloc.getUpcomingMovies();
                  },
                  child: ListView.builder(
                      itemCount: snapshot.data!.results!.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        String? backdropPath = snapshot.data!.results![index].backdropPath;
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: (backdropPath != null)
                                  ? Image.network(
                                      Config.imageUrl200 + backdropPath,
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) {
                                        return const SizedBox(width: 100, child: Center(child: Text("Error")));
                                      },
                                    )
                                  : const SizedBox(width: 200, height: 200, child: Text("Error")),
                              title: Text(
                                snapshot.data!.results![index].title! +
                                    " | " +
                                    DateFormat('yyyy').format(snapshot.data!.results![index].releaseDate!),
                                style: const TextStyle(fontSize: 15),
                              ),
                              subtitle: Text(
                                snapshot.data!.results![index].overview!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MovieDetailPage(
                                              movieId: snapshot.data!.results![index].id!,
                                              title: snapshot.data!.results![index].title!,
                                            )));
                              },
                            ),
                            Divider()
                          ],
                        );
                      }),
                );
        }
        return Container(alignment: Alignment.center, child: ColorLoader5());
      },
    );
  }
}
