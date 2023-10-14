import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:templesapp/more.dart';
import 'package:templesapp/Home.dart';
import 'package:templesapp/profile.dart';
import 'package:templesapp/search.dart';

class H extends StatefulWidget {
  const H({super.key});

  @override
  State<H> createState() => _HState();
}

class _HState extends State<H> {
  int index = 0;
  final screens = [
    Page1(),
    Search(),
    Profile(),
    More(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.white,
        ),
        child: NavigationBar(
          backgroundColor: Colors.red,
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          height: 50,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            NavigationDestination(
                icon: Icon(CupertinoIcons.square_split_2x2_fill), label: 'More')
          ],
        ),
      ),
    );
  }
}
