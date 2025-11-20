import 'package:flutter/material.dart';

import 'explore_page.dart';
import 'my_books_page.dart';
import 'profile_page.dart';
import 'analytics_page.dart';
import 'settings_page.dart';
import '../viewmodels/explore_view_model.dart';
import '../widgets/drawer_widget.dart';
import 'login_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  String _drawerSelected = '';

  final ExploreViewModel _exploreVm = ExploreViewModel();

  final List<Widget?> _pages = [const MyBooksPage(), null];

  void _onItemTapped(int index) {
    if (index == 0) {
      _exploreVm.setShowBooks(false);
    }

    if (index == 1) {
      _exploreVm.ensureLoaded();
      _exploreVm.setShowBooks(true);
    }

    setState(() {
      _drawerSelected = '';
      if (_pages[index] == null) {
        _pages[index] = index == 0 ? const MyBooksPage() : ExplorePage(vm: _exploreVm);
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
    Widget bodyContent;

    switch (_drawerSelected) {
      case 'Profile':
        bodyContent = const ProfilePage();
        break;
      case 'Analytics':
        bodyContent = const AnalyticsPage();
        break;
      case 'Settings':
        bodyContent = const SettingsPage();
        break;
      case 'Logout':
        bodyContent = const LoginPage();
      default:
        bodyContent = IndexedStack(
          index: _selectedIndex,
          children: [
            _pages[0]!,
            _pages[1] ?? const SizedBox.shrink(),
          ],
        );
    }

    return Scaffold(
      appBar: (bodyContent is LoginPage)
          ? null
          : AppBar(
              backgroundColor: Colors.black38,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text('PawsHurtToRead', style: TextStyle(color: Colors.white)),
            ),
      drawer: (bodyContent is LoginPage)
          ? null
          : DrawerWidget(
              onItemTap: (page) {
                setState(() {
                  _drawerSelected = page;
                });
              },
            ),
      body: bodyContent,
      backgroundColor: Colors.black,
      bottomNavigationBar: (bodyContent is LoginPage)
          ? null
          : BottomNavigationBar(
              backgroundColor: Colors.black,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: bodyContent is IndexedStack ? Colors.white : Colors.blueGrey,
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
