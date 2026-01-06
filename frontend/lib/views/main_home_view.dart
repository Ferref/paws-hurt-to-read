import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

import 'package:frontend/common/drawer_widget.dart';

import 'package:frontend/views/explore_view.dart';
import 'package:frontend/views/my_books/my_books_view.dart';
import 'package:frontend/views/profile_view.dart';
import 'package:frontend/views/analytics/analytics_view.dart';
import 'package:frontend/views/settings/settings_view.dart';
import 'package:frontend/views/login_view.dart';

import 'package:frontend/viewmodels/auth_view_model.dart';
import 'package:frontend/viewmodels/explore_view_model.dart';

enum _DrawerPage { none, profile, analytics, settings, logout }

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  static const String _defaultTitle = 'PawsHurtToRead';

  final ExploreViewModel _exploreVm = getIt<ExploreViewModel>();

  final List<Widget?> _tabPages = [
    const MyBooksView(),
    null,
  ];

  _DrawerPage _drawerPage = _DrawerPage.none;
  int _selectedIndex = 0;

  bool get _isLogin => _drawerPage == _DrawerPage.logout;
  bool get _showBottomNav => !_isLogin;
  void _onItemTapped(int index) {
    _handleExploreStateForTab(index);

    setState(() {
      _drawerPage = _DrawerPage.none;
      _ensureTabPageBuilt(index);
      _selectedIndex = index;
    });
  }

  void _handleExploreStateForTab(int index) {
    if (index == 0) {
      _exploreVm.setShowBooks(false);
      return;
    }

    if (index == 1) {
      _exploreVm.ensureLoaded();
      _exploreVm.setShowBooks(true);
    }
  }

  void _ensureTabPageBuilt(int index) {
    if (_tabPages[index] != null) {
      return;
    }

    if (index == 1) {
      _tabPages[index] = ExploreView(vm: _exploreVm);
    }
  }

  void _logout() {
    // TODO: Confirmation box
    getIt<AuthViewModel>().destroy();
    setState(() => _drawerPage = _DrawerPage.logout);
  }

  void _onDrawerItemTap(String page) {
    final selection = _mapDrawerSelection(page);

    if (selection == _DrawerPage.logout) {
      _logout();
      return;
    }

    setState(() => _drawerPage = selection);
  }

  _DrawerPage _mapDrawerSelection(String page) {
    switch (page) {
      case 'Profile':
        return _DrawerPage.profile;
      case 'Analytics':
        return _DrawerPage.analytics;
      case 'Settings':
        return _DrawerPage.settings;
      case 'Logout':
        return _DrawerPage.logout;
      default:
        return _DrawerPage.none;
    }
  }

  String get _title {
    switch (_drawerPage) {
      case _DrawerPage.profile:
        return 'Profile';
      case _DrawerPage.analytics:
        return 'Analytics';
      case _DrawerPage.settings:
        return 'Settings';
      case _DrawerPage.logout:
        return 'Logout';
      case _DrawerPage.none:
        return _defaultTitle;
    }
  }

  Widget get _body {
    switch (_drawerPage) {
      case _DrawerPage.profile:
        return const ProfileView();
      case _DrawerPage.analytics:
        return const AnalyticsView();
      case _DrawerPage.settings:
        return const SettingsView();
      case _DrawerPage.logout:
        return const LoginView();
      case _DrawerPage.none:
        return IndexedStack(
          index: _selectedIndex,
          children: [
            _tabPages[0]!,
            _tabPages[1] ?? const SizedBox.shrink(),
          ],
        );
    }
  }

  PreferredSizeWidget? get _appBar {
    if (_isLogin) {
      return null;
    }

    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(_title, style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor)),
    );
  }

  Widget? get _drawer {
    if (_isLogin) {
      return null;
    }

    return DrawerWidget(onItemTap: _onDrawerItemTap);
  }

  Widget? get _bottomNav {
    if (!_showBottomNav) {
      return null;
    }

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).appBarTheme.foregroundColor,
      unselectedItemColor: Theme.of(context).appBarTheme.shadowColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Books'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  @override
  void dispose() {
    _exploreVm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      drawer: _drawer,
      body: _body,
      bottomNavigationBar: _bottomNav,
    );
  }
}