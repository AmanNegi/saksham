import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/admin/presentation/admin_control_page.dart';
import 'package:swaraksha/core/home/application/home_manager.dart';
import 'package:swaraksha/core/issues/presentation/add_issue_page.dart';
import 'package:swaraksha/core/issues/presentation/admin_issue_page.dart';
import 'package:swaraksha/core/issues/presentation/my_issues_page.dart';
import 'package:swaraksha/core/notification/application/notification_manager.dart';
import 'package:swaraksha/core/notification/presentation/notification_page.dart';
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
  void initState() {
    GetIt.instance.get<NotificationManager>().attachPoller();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        title: Padding(
          padding: const EdgeInsets.only(left:8.0),
          
          child: Text("Hello, ${appState.value.name}"),
        ),
        actions: isAdmin()
            ? []
            : [
                ValueListenableBuilder(
                    valueListenable: notificationCount,
                    builder: (context, value, child) {
                      return Stack(children: [
                        IconButton(
                          onPressed: () {
                            navigateTo(const NotificationPage(), context);
                          },
                          icon: const Icon(Icons.notifications),
                        ),
                        if (value > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ]);
                    }),
              ],
      ),
      body: LayoutBuilder(builder: (context, layout) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (isAdmin()) const StatsSection(),
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
                isAdmin() ? "Admin Panel" : "Emergency Contacts",
                "assets/emergency_contacts.svg",
                () {
                  if (!isAdmin()) {
                    return navigateTo(const EmergencyNumbersPage(), context);
                  }
                  navigateTo(const AdminControlPage(), context);
                },
                layout.maxHeight,
              ),
            ],
          ),
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

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  bool isLoading = true;
  Stats? stats;

  @override
  void initState() {
    super.initState();
    HomeManager.getStats().then((value) => {
          stats = value,
          isLoading = false,
          setState(() {}),
        });
  }

  getStats() async {
    var value = await HomeManager.getStats();
    stats = value;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.2 * getHeight(context),
      child: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (stats == null)
              ? Container()
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 1.0,
                                blurRadius: 5.0,
                                offset: Offset.zero,
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Last 7 days"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${stats!.totalIssuesClosedInLast30Days}",
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800,
                                        color: accentColor,
                                      ),
                                    ),
                                    Text(
                                      "/${stats!.totalIssuesOpenedInLast7Days}",
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 1.0,
                                  blurRadius: 5.0,
                                  offset: Offset.zero,
                                )
                              ]),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Last 30 days"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${stats!.totalIssuesClosedInLast30Days}",
                                      style: const TextStyle(
                                        color: accentColor,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      "/${stats!.totalIssuesOpenedInLast30Days}",
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
