import 'package:flutter/material.dart';
import 'package:youtap/data/api_request.dart';
import 'package:youtap/injections/injection.dart';
import 'package:youtap/views/pages/movies/movie_page.dart';
import 'package:youtap/views/pages/page_profile.dart';
import 'package:youtap/views/pages/tv/tv_page.dart';

class PageMain extends StatefulWidget {
  const PageMain({Key? key}) : super(key: key);

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  int _selectedIndex = 0;
  String _mainPageTitle = "";
  static const List<Widget> _widgetOptions = <Widget>[PageMovie(), PageTV(), PageProfile()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          setState(() {
            _mainPageTitle = "Movies";
          });
          break;
        case 1:
          setState(() {
            _mainPageTitle = "TV";
          });
          break;
        case 2:
          setState(() {
            _mainPageTitle = "Profile";
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getIt<APIRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(_mainPageTitle),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
