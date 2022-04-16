import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtap/bloc/bloc.dart';
import 'package:youtap/model/tv/tv_on_the_air.dart';
import 'package:youtap/views/pages/tv/tv_detail_page.dart';

import '../../../configs/config.dart';
import '../../../injections/injection.dart';
import '../../templates/loaders/color_loader_5.dart';

class TVOnTheAirList extends StatefulWidget {
  const TVOnTheAirList({Key? key}) : super(key: key);

  @override
  _TVOnTheAirListState createState() => _TVOnTheAirListState();
}

class _TVOnTheAirListState extends State<TVOnTheAirList> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getIt<Bloc>().tvOnTheAirBloc.getTVOnTheAir();
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
        getIt<Bloc>().tvOnTheAirBloc.loadMoreTVOnTheAir();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getIt<Bloc>().tvOnTheAirBloc.tvOnTheAirList,
      builder: (context, AsyncSnapshot<TVOnTheAir> snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
          return InkWell(
              child: const Center(child: Text("Error occured\n Please tap to retry!")),
              onTap: () => setState(() {
                    getIt<Bloc>().tvOnTheAirBloc.getTVOnTheAir();
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
                    return getIt<Bloc>().tvOnTheAirBloc.getTVOnTheAir();
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
                                snapshot.data!.results![index].name! +
                                    " | " +
                                    DateFormat('yyyy').format(snapshot.data!.results![index].firstAirDate!),
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
                                        builder: (_) => TVDetailPage(
                                              tvId: snapshot.data!.results![index].id!,
                                              title: snapshot.data!.results![index].name!,
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
