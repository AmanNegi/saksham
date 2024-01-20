import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/issues/presentation/add_issue_page.dart';
import 'package:swaraksha/core/issues/presentation/admin_issue_page.dart';
import 'package:swaraksha/core/issues/presentation/my_issues_page.dart';
import 'package:swaraksha/core/numbers/emergency_numbers_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !isAdmin()
          ? FloatingActionButton(
              onPressed: () {
                navigateTo(const AddIssuePage(), context);
              },
              child: const Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: Text("Hello, ${appState.value.name}"),
      ),
      body: LayoutBuilder(builder: (context, layout) {
        return Column(
          children: [
            if (!isAdmin())
              getContainer(
                "View Issues",
                "assets/create_issue.svg",
                () => navigateTo(const MyIssuesPage(), context),
                layout.maxHeight,
              ),
            if (isAdmin())
              getContainer(
                "View Issues",
                "assets/view_issue.svg",
                () => navigateTo(const AdminIssuePage(), context),
                layout.maxHeight,
              ),
            getContainer(
              isAdmin() ? "Resolved Issues" : "Emergency Contacts",
              "assets/emergency_contacts.svg",
              () {
                if (!isAdmin()) {
                  navigateTo(const EmergencyNumbersPage(), context);
                }
              },
              layout.maxHeight,
            ),
          ],
        );
      }),
    );
  }

  Widget getContainer(
    String name,
    String image,
    Function onClick,
    double height,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          onClick();
        },
        child: Ink(
          height: 0.4 * height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(image),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
