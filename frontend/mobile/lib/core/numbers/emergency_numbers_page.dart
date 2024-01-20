import 'package:flutter/material.dart';
import 'package:swaraksha/core/admin/application/admin.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/region.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';

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
      regions = value;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                selectedRegion = value!;
                subRegions = selectedRegion!.subRegions;
                setState(() {});
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
                selectedSubRegion = value!;
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 10),
          ActionButton(
            onPressed: () async {
              if (selectedRegion == null) {
                return showToast("Select a region");
              }
              if (selectedSubRegion == null) {
                return showToast("Select a sub-region");
              }

              numbers = selectedSubRegion!.numbers;
              setState(() {});
            },
            text: "Load Numbers",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(numbers[index].departmentName),
                  subtitle: Text(numbers[index].number),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
