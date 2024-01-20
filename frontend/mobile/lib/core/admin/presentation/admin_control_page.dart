import 'package:flutter/material.dart';
import 'package:swaraksha/core/admin/presentation/add_department_page.dart';
import 'package:swaraksha/core/admin/presentation/add_numbers.dart';
import 'package:swaraksha/core/admin/presentation/add_subregion_page.dart';
import 'package:swaraksha/core/admin/presentation/view_numbers.dart';
import 'package:swaraksha/core/auth/presentation/login_page.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/widgets/action_button.dart';

class AdminControlPage extends StatefulWidget {
  const AdminControlPage({super.key});

  @override
  State<AdminControlPage> createState() => _AdminControlPageState();
}

class _AdminControlPageState extends State<AdminControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Control"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 30.0,
        ),
        child: Column(children: [
          ActionButton(
            text: "Add Numbers",
            onPressed: () {
              navigateTo(const AddNumbers(), context);
            },
          ),
          const SizedBox(height: 20),
          ActionButton(
            text: "Add Department",
            onPressed: () {
              navigateTo(const AddDepartmentPage(), context);
            },
          ),
          const SizedBox(height: 20),
          ActionButton(
            text: "Add Sub Region Page",
            onPressed: () {
              navigateTo(const AddSubRegionPage(), context);
            },
          ),
          const SizedBox(height: 20),
          ActionButton(
            text: "View Numbers Page",
            onPressed: () {
              navigateTo(const ViewEmergencyNumbers(), context);
            },
          ),
          const SizedBox(height: 20),
          ActionButton(
            text: "Normal Flow",
            onPressed: () {
              navigateTo(const LoginPage(), context);
            },
          ),
        ]),
      ),
    );
  }
}
