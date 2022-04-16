import 'package:flutter/material.dart';
import 'package:youtap/views/features/tv/tv_on_the_air_list.dart';
import 'package:youtap/views/features/tv/tv_popular_list.dart';

class PageTV extends StatefulWidget {
  const PageTV({Key? key}) : super(key: key);

  @override
  PageTVState createState() => PageTVState();
}

class PageTVState extends State<PageTV> with AutomaticKeepAliveClientMixin<PageTV>, WidgetsBindingObserver {
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
                            "Popular TV",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Padding(padding: EdgeInsets.all(2.0), child: TVPopularList()),
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
                            "On the Air TV",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: Padding(padding: EdgeInsets.all(2.0), child: TVOnTheAirList()),
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
