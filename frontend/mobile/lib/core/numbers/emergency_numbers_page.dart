import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/admin/application/admin.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/region.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbersPage extends StatefulWidget {
  const EmergencyNumbersPage({super.key});

  @override
  State<EmergencyNumbersPage> createState() => _EmergencyNumbersPageState();
}

class _EmergencyNumbersPageState extends State<EmergencyNumbersPage> {
  bool isLoading = true;
  Region? selectedRegion;
  SubRegion? selectedSubRegion;

  List<Region> regions = [];
  List<SubRegion> subRegions = [];

  List<DepartmentNumber> numbers = [];

  String res = "";

  @override
  void initState() {
    super.initState();
    AuthManager().getRegions().then((value) {
      isLoading = false;

      // find region equals to the region of the user
      var res =
          value.where((element) => element.name == appState.value.region).first;

      for (var element in res.subRegions) {
        if (element.name == appState.value.subRegion) {
          numbers = element.numbers;
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Numbers"),
      ),
      body: _getFields(),
    );
  }

  Widget _getFields() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(),
            ),
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: numbers[index].number),
                    );
                    showToast("Copied Number Successfully");
                  },
                  title: Text(numbers[index].departmentName),
                  subtitle: Text(numbers[index].number),
                  trailing: GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("tel:${numbers[index].number}"));
                    },
                    child: const CircleAvatar(
                      backgroundColor: accentColor ,
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
