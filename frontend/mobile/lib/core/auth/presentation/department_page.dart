import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/core/auth/presentation/region_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/department.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/back_layout.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';

class DepartmentPage extends StatefulWidget {
  final bool isFromSettings;
  const DepartmentPage({super.key, this.isFromSettings = false});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  Department? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackLayout(
        child: Column(
          children: [
            Container(
              height: 0.5 * getHeight(context),
              width: double.infinity,
              color: cardColor,
              child: Column(
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/admin.svg",
                    height: 0.3 * getHeight(context),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 0.05 * getHeight(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Department",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "As an admin, you get to choose departments",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.05 * getHeight(context)),
                  FieldWrapper(
                    child: FutureBuilder(
                      future: AuthManager().getDepartments(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return DropdownButton<Department>(
                            underline: Container(),
                            hint: const Text("Select Department"),
                            isExpanded: true,
                            value: selectedDepartment,
                            padding: const EdgeInsets.all(8.0),
                            items: snapshot.data!.map((e) {
                              return DropdownMenuItem<Department>(
                                value: e,
                                child: Text(e.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDepartment = value!;
                              });
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ActionButton(
                    onPressed: () {
                      AppState newAppState = AppState(
                        isLoggedIn: true,
                        name: appState.value.name,
                        phone: appState.value.phone,
                        uid: appState.value.uid,
                        groupId: appState.value.groupId,
                        region: appState.value.region,
                        subRegion: appState.value.subRegion,
                        userType: appState.value.userType,
                        department: selectedDepartment!.name,
                        departmentId: selectedDepartment!.id,
                      );

                      GetIt.instance<AppCache>().updateAppCache(newAppState);

                      if (widget.isFromSettings) {
                        Navigator.pop(context);
                        return;
                      }
                      navigateTo(const RegionPage(), context);
                    },
                    text: "Continue",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
