import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar/analytics_screen.dart';

import '../widgets/navbar/explore_screen.dart';
import '../widgets/navbar/my_books_screen.dart';
import '../viewmodels/explore_view_model.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final ExploreViewModel _exploreVm = ExploreViewModel();

  final List<Widget?> _pages = [const MyBooksScreen(), null];

  void _onItemTapped(int index) {
    if (index == 0) {
      _exploreVm.setShowBooks(false);
    }

    if (index == 1) {
      _exploreVm.ensureLoaded();
      _exploreVm.setShowBooks(true);
    }

    setState(() {
      if (_pages[index] == null) {
        _pages[index] = index == 0 ? const MyBooksScreen() : ExploreScreen(vm: _exploreVm);
      }
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _exploreVm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _pages[0]!,
          _pages[1] ?? const SizedBox.shrink(),
        ],
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}