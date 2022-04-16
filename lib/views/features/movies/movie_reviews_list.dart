import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtap/bloc/bloc.dart';
import 'package:youtap/injections/injection.dart';
import 'package:youtap/model/movie/movie_reviews.dart';
import 'package:youtap/views/templates/loaders/color_loader_5.dart';

class MovieReviewsList extends StatefulWidget {
  final int movieId;

  const MovieReviewsList({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieReviewsListState createState() => _MovieReviewsListState();
}

class _MovieReviewsListState extends State<MovieReviewsList> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  var deviceSize;

  @override
  void initState() {
    getIt<Bloc>().movieReviewsBloc.getMovieReviews(widget.movieId);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: getIt<Bloc>().movieReviewsBloc.movieReviews,
      builder: (context, AsyncSnapshot<MovieReviews> snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
          return InkWell(
              child: const Center(child: Text("Error occured\n Please tap to retry!")),
              onTap: () => setState(() {
                    getIt<Bloc>().movieReviewsBloc.getMovieReviews(widget.movieId);
                  }));
        } else if (snapshot.hasData) {
          if (snapshot.data!.totalResults! > 0) {
            return SizedBox(
              height: deviceSize.height * 0.66,
              child: Card(
                child: Column(
                  children: [
                    const Flexible(
                        flex: 1,
                        child: Center(
                            child: Text(
                          "Reviews",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    Flexible(
                      flex: 11,
                      child: RefreshIndicator(
                        onRefresh: () {
                          return getIt<Bloc>().movieReviewsBloc.getMovieReviews(widget.movieId);
                        },
                        child: ListView.builder(
                            itemCount: snapshot.data!.results!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: SizedBox(
                                  height: deviceSize.height / 3,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blueAccent),
                                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Container(
                                                color: Colors.lightBlueAccent,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(snapshot.data!.results![index].authorDetails!.name!),
                                                    Text(DateFormat('yyyy-MM-dd')
                                                        .format(snapshot.data!.results![index].createdAt!)),
                                                    Text(
                                                      snapshot.data!.results![index].authorDetails!.rating!.toString(),
                                                      style:
                                                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: SingleChildScrollView(
                                                    child: Text(snapshot.data!.results![index].content!)))
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        }
        return Container(alignment: Alignment.center, child: ColorLoader5());
      },
    );
  }
}
