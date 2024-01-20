import 'package:flutter/material.dart';
import 'package:swaraksha/core/admin/application/admin.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/region.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';

class ViewEmergencyNumbers extends StatefulWidget {
  const ViewEmergencyNumbers({super.key});

  @override
  State<ViewEmergencyNumbers> createState() => _ViewEmergencyNumbersState();
}

class _ViewEmergencyNumbersState extends State<ViewEmergencyNumbers> {
  bool isLoading = true;
  Region? selectedRegion;
  List<Region> regions = [];

  String res = "";

  @override
  void initState() {
    super.initState();

    AdminManager.getNumbersForRegion(selectedRegion!.id).then((value) {
      isLoading = false;
      res = value;
      setState(() {});
    });

    // AuthManager().getRegions().then((value) {
    //   isLoading = false;
    //   regions = value;
    //   setState(() {});
    // });
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
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
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          ActionButton(
            onPressed: () async {
              if (selectedRegion == null) {
                return showToast("Select a region");
              }
              isLoading = true;
              res = await AdminManager.getNumbersForRegion(selectedRegion!.id);
              isLoading = false;
              setState(() {});
            },
            text: "Continue",
          ),
          Expanded(child: Text(res)),
        ],
      ),
    );
  }
}
