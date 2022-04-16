import 'package:flutter/material.dart';
import 'package:youtap/views/features/movies/now_playing_movies_list.dart';
import 'package:youtap/views/features/movies/popular_movies_list.dart';
import 'package:youtap/views/features/movies/upcoming_movies_list.dart';

class PageMovie extends StatefulWidget {
  const PageMovie({Key? key}) : super(key: key);

  @override
  PageMovieState createState() => PageMovieState();
}

class PageMovieState extends State<PageMovie> with AutomaticKeepAliveClientMixin<PageMovie>, WidgetsBindingObserver {
  late var deviceSize;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: SizedBox(
                height: deviceSize.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Popular Movies",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Padding(padding: EdgeInsets.all(2.0), child: PopularMoviesList()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: SizedBox(
                height: deviceSize.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Now Playing Movies",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Padding(padding: EdgeInsets.all(2.0), child: NPMoviesList()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: SizedBox(
                height: deviceSize.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Upcoming Movies",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Padding(padding: EdgeInsets.all(2.0), child: UpcomingMoviesList()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
