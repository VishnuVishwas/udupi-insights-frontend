import 'package:flutter/material.dart';
import 'navPages/home_page.dart';
import 'navPages/profile_page.dart';

import 'navPages/map_page.dart';
import 'navPages/wishList_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // pages
  List pages = [
    const HomePage(),
    MapPage(),
    const WishlistPage(),
    const ProfilePage(),
  ];

  // set icon selected
  int _selectedIndex = 0;
  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // get page
      body: pages[_selectedIndex],

      // bottom Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTap,
        // styling
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.blueAccent),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        // items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Maps'), // Maps
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
