import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

import 'package:frontend/widgets/drawer_widget.dart';

import 'package:frontend/views/explore_view.dart';
import 'package:frontend/views/my_books_view.dart';
import 'package:frontend/views/profile_view.dart';
import 'package:frontend/views/analytics_view.dart';
import 'package:frontend/views/settings_view.dart';
import 'package:frontend/views/login_view.dart';

import 'package:frontend/viewmodels/session_view_model.dart';
import 'package:frontend/viewmodels/explore_view_model.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final ExploreViewModel _exploreVm = getIt<ExploreViewModel>();
  final List<Widget?> _pages = [const MyBooksView(), null];

  String _title = "PaswHurtToRead";
  String _drawerSelected = '';
  int _selectedIndex = 0;
  
  String get title => _title;

  set title(String name) {
    _title = name;
  }

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
        _pages[index] = index == 0 ? const MyBooksView() : ExploreView(vm: _exploreVm);
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
        title = 'Profile';
        bodyContent = const ProfileView();
        break;
      case 'Analytics':
        title = 'Analytics';
        bodyContent = const AnalyticsView();
        break;
      case 'Settings':
        title = 'Settings';
        bodyContent = const SettingsView();
        break;
      case 'Logout':
        title = 'Logout';
        
        // TODO: Confirmation box
        final sessionService = getIt<SessionViewModel>();
        sessionService.destroy();
        bodyContent = const LoginView();

      default:
        title = 'PawsHurtTorRead';
        bodyContent = IndexedStack(
          index: _selectedIndex,
          children: [
            _pages[0]!,
            _pages[1] ?? const SizedBox.shrink(),
          ],
        );
    }

    return Scaffold(
      appBar: (bodyContent is LoginView)
          ? null
          : AppBar(
              backgroundColor: Colors.black38,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(title, style: TextStyle(color: Colors.white)),
            ),
      drawer: (bodyContent is LoginView)
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
      bottomNavigationBar: (bodyContent is LoginView)
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
