import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/core/home/presentation/user/dashboard_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/region.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/back_layout.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';

class RegionPage extends StatefulWidget {
  final bool isFromSettings;
  const RegionPage({super.key, this.isFromSettings = false});

  @override
  State<RegionPage> createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  Region? selectedRegion;
  SubRegion? selectedSubRegion;

  List<SubRegion> subRegions = [];
  List<Region> regions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    AuthManager().getRegions().then((value) {
      isLoading = false;
      regions = value;
      setState(() {});
    });
  }

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
                    "assets/region.svg",
                    height: 0.3 * getHeight(context),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 0.05 * getHeight(context)),
            const SizedBox(width: double.infinity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Region",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "We tailor your experience based on your region",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _getFields(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFields() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Column(
      children: [
        FieldWrapper(
          child: DropdownButton<Region>(
            hint: const Text("Select Region"),
            value: selectedRegion,
            isExpanded: true,
            underline: Container(),
            items: regions.map((e) {
              return DropdownMenuItem<Region>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedRegion = value!;
                subRegions = value.subRegions;
                if (subRegions.isEmpty) {
                  showToast("No sub-regions found for this region");
                }
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        FieldWrapper(
          child: DropdownButton<SubRegion>(
            value: selectedSubRegion,
            hint: const Text("Select Sub-Region"),
            isExpanded: true,
            underline: Container(),
            items: subRegions.map((e) {
              return DropdownMenuItem<SubRegion>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSubRegion = value!;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        ActionButton(
          onPressed: onContinuePressed,
          text: "Continue",
        ),
      ],
    );
  }

  void onContinuePressed() {
    if (selectedRegion == null || selectedSubRegion == null) {
      showToast("Please select region and sub-region");
      return;
    }

    GetIt.instance.get<AppCache>().updateAppCache(
          AppState(
            isLoggedIn: appState.value.isLoggedIn,
            name: appState.value.name,
            phone: appState.value.phone,
            uid: appState.value.uid,
            department: appState.value.department,
            departmentId: appState.value.departmentId,
            region: selectedRegion!.name,
            subRegion: selectedSubRegion!.name,
            groupId: selectedSubRegion!.groupId,
            userType: appState.value.userType,
          ),
        );

    if (widget.isFromSettings) {
      return Navigator.pop(context);
    }
    navigateToAndRemoveUntil(const DashboardPage(), context);
  }
}
