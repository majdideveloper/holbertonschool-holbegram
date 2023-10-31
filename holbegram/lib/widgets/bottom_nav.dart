import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/pages/profile_screen.dart';

import '../screens/pages/add_image.dart';
import '../screens/pages/favorite.dart';
import '../screens/pages/feed.dart';
import '../screens/pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Feed(),
          Search(),
          AddImage(),
          Favorite(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          itemBottom(icon: Icons.home, text: "Home"),
          itemBottom(icon: Icons.home, text: "Home"),
          itemBottom(icon: Icons.home, text: "Home"),
          itemBottom(icon: Icons.home, text: "Home"),
          itemBottom(icon: Icons.home, text: "Home"),
        ],
      ),
    );
  }
}

BottomNavyBarItem itemBottom({
  required String text,
  required IconData icon,
}) {
  return BottomNavyBarItem(
    icon: Icon(icon),
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 25,
      ),
    ),
    activeColor: Colors.red,
    textAlign: TextAlign.center,
    inactiveColor: Colors.black,
  );
}
