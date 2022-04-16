import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtap/bloc/bloc.dart';
import 'package:youtap/configs/config.dart';
import 'package:youtap/injections/injection.dart';
import 'package:youtap/model/movie/movie_detail.dart';
import 'package:youtap/views/features/movies/movie_reviews_list.dart';
import 'package:youtap/views/templates/loaders/color_loader_5.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  final String title;

  const MovieDetailPage({Key? key, required this.movieId, required this.title}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> with WidgetsBindingObserver {
  var deviceSize;

  @override
  void initState() {
    getIt<Bloc>().movieDetailBloc.getMovieDetail(widget.movieId);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        body: StreamBuilder(
      stream: getIt<Bloc>().movieDetailBloc.movieDetail,
      builder: (context, AsyncSnapshot<MovieDetail> snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
          return InkWell(
              child: const Center(child: Text("Error occured\n Please tap to retry!")),
              onTap: () => setState(() {
                    getIt<Bloc>().movieDetailBloc.getMovieDetail(widget.movieId);
                  }));
        } else if (snapshot.hasData) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  expandedHeight: 300.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.network(
                        Config.imageUrl500 + snapshot.data!.posterPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) {
                          return const  Text("Error");
                        },
                      )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.title,
                              style: TextStyle(fontSize: 32, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ];
            },
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _movieDetail(snapshot.data!),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MovieReviewsList(movieId: widget.movieId),
                ),
              ],
            ),
          );
        }
        return Container(alignment: Alignment.center, child: ColorLoader5());
      },
    ));
  }

  Widget _movieDetail(MovieDetail movieDetail) {
    return SizedBox(
      height: deviceSize.height / 3,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Expanded(flex: 1, child: Text("Storyline")),
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Text(movieDetail.overview!),
                  )),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    const Expanded(flex: 1, child: Text("Genres")),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                          itemCount: movieDetail.genres!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blueAccent),
                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(movieDetail.genres![index].name!),
                                  ))),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Text(movieDetail.status!),
                    ),
                    Flexible(
                      child: Text(DateFormat('yyyy-MM-dd').format(movieDetail.releaseDate!)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
