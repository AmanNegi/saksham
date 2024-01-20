import 'package:flutter/material.dart';
import 'package:swaraksha/core/admin/application/admin.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/region.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import 'package:swaraksha/widgets/text_field.dart';

class AddSubRegionPage extends StatefulWidget {
  const AddSubRegionPage({super.key});

  @override
  State<AddSubRegionPage> createState() => _AddSubRegionPageState();
}

class _AddSubRegionPageState extends State<AddSubRegionPage> {
  String newSubRegionName = "";
  List<Region> regions = [];
  bool isLoading = false;
  Region? selectedRegion;

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
        title: const Text("Add Sub Region"),
      ),
      body: LoadingLayout(
        isLoading: isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              _getRegionFields(),
              CustomTextField(
                hint: "New Sub Region Name",
                value: newSubRegionName,
                onChanged: (v) {
                  newSubRegionName = v;
                },
              ),
              const SizedBox(height: 20),
              ActionButton(
                text: "Add Sub-Region",
                onPressed: () {
                  if (newSubRegionName.isEmpty) {
                    showToast("Please enter sub region name");
                    return;
                  }
                  if (selectedRegion == null) {
                    showToast("Please select region");
                    return;
                  }

                  isLoading = true;
                  setState(() {});

                  AdminManager.addSubRegion(
                    selectedRegion!.name.trim(),
                    newSubRegionName.trim(),
                  ).then((value) {
                    isLoading = false;
                    setState(() {});

                    if (value) {
                      showToast("Sub Region Added");
                      newSubRegionName = " ";
                      setState(() {});
                    } else {
                      showToast("Failed to add sub region");
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRegionFields() {
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
              selectedRegion = value!;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
