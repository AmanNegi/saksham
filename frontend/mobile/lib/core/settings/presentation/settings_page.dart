import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/core/auth/presentation/department_page.dart';
import 'package:swaraksha/core/auth/presentation/login_page.dart';
import 'package:swaraksha/core/auth/presentation/region_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          ListTile(
            title: const Text("Change Department"),
            leading: const Icon(Icons.group),
            onTap: () {
              navigateTo(
                const DepartmentPage(isFromSettings: true),
                context,
              );
            },
          ),
          ListTile(
            title: const Text("Change Region"),
            leading: const Icon(Icons.location_on),
            onTap: () {
              navigateTo(
                const RegionPage(isFromSettings: true),
                context,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              GetIt.instance<AppCache>().clearAppCache();
              navigateToAndRemoveUntil(const LoginPage(), context);
            },
          ),
        ],
      ),
    );
  }
}
