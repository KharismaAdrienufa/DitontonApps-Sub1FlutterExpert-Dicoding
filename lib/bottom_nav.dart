import 'package:flutter/material.dart';
import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int indexPage = 0;

  final List<Widget> pages = [
    HomeMoviePage(),
    WatchlistMoviesPage(),
    HomeTvPage(),
    WatchlistTvPage(),
    AboutPage()
  ];

  @override
  // ignore: override_on_non_overriding_member
  void onTapped(int index) {
    setState(() {
      indexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        backgroundColor: kRichBlack,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
          BottomNavigationBarItem(
              icon: Icon(Icons.save_alt), label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.tv_rounded), label: 'Tv'),
          BottomNavigationBarItem(
              icon: Icon(Icons.save_alt), label: 'Watchlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'About')
        ],
        onTap: onTapped,
        selectedItemColor: kMikadoYellow,
      ),
    );
  }
}
