import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swaraksha/core/auth/presentation/login_page.dart';
import 'package:swaraksha/core/chat/presentation/chat_page.dart';
import 'package:swaraksha/core/issues/application/issues_manager.dart';
import 'package:swaraksha/core/issues/presentation/add_issue_page.dart';
import 'package:swaraksha/core/issues/presentation/admin_issue_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          IssuesManager().getIssuesByDepartment();
        },
        child: const Text("Check"),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(const ChatPage(), context);
            },
            icon: const Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {
              navigateTo(const AdminIssuePage(), context);
            },
            icon: const Icon(Icons.map),
          ),
          IconButton(
            onPressed: () {
              navigateTo(const AddIssuePage(), context);
            },
            icon: const Icon(Icons.add_circle),
          ),
          IconButton(
            onPressed: () {
              GetIt.instance<AppCache>().clearAppCache();
              navigateToAndRemoveUntil(const LoginPage(), context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(
          appState.value.toJson(),
        ),
      ),
    );
  }
}
