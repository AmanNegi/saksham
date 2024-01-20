import 'package:flutter/material.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/chat/presentation/chat_page.dart';
import 'package:swaraksha/core/home/presentation/user/home_page.dart';
import 'package:swaraksha/core/settings/presentation/settings_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        onDestinationSelected: (value) {
          _selectedIndex = value;
          _tabController.animateTo(_selectedIndex);
          setState(() {});
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UserHomePage(),

          ChatPage(),

          SettingsPage(),
        ],
      ),
    );
  }
}
