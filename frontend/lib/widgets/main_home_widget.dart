import 'package:flutter/material.dart';

import 'explore_widget.dart';
import 'my_books_widget.dart';
import 'profile_widget.dart';
import 'analytics_widget.dart';
import 'settings_widget.dart';
import '../viewmodels/explore_view_model.dart';
import 'drawer_widget.dart';
import 'login_widget.dart';

class MainHomeWidget extends StatefulWidget {
  const MainHomeWidget({super.key});

  @override
  State<MainHomeWidget> createState() => _MainHomeWidgetState();
}

class _MainHomeWidgetState extends State<MainHomeWidget> {
  int _selectedIndex = 0;
  String _drawerSelected = '';

  final ExploreViewModel _exploreVm = ExploreViewModel();

  final List<Widget?> _pages = [const MyBooksWidget(), null];

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
        _pages[index] = index == 0 ? const MyBooksWidget() : ExploreWidget(vm: _exploreVm);
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
        bodyContent = const ProfileWidget();
        break;
      case 'Analytics':
        bodyContent = const AnalyticsWidget();
        break;
      case 'Settings':
        bodyContent = const SettingsWidget();
        break;
      case 'Logout':
        bodyContent = const LoginWidget();
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
      appBar: (bodyContent is LoginWidget) ? null : AppBar(
        backgroundColor: Colors.black38,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('PawsHurtToRead', style: TextStyle(color: Colors.white)),
      ),
      drawer: (bodyContent is LoginWidget) ? null : DrawerWidget(
        onItemTap: (page) {
          setState(() {
            _drawerSelected = page;
          });
        },
      ),
      body: bodyContent,
      backgroundColor: Colors.black,
      bottomNavigationBar: (bodyContent is LoginWidget) ? null : BottomNavigationBar(
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
