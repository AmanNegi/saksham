import 'package:flutter/material.dart';
import 'package:swaraksha/core/admin/application/admin.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/department.dart';
import 'package:swaraksha/models/region.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import 'package:swaraksha/widgets/text_field.dart';

class AddNumbers extends StatefulWidget {
  const AddNumbers({super.key});

  @override
  State<AddNumbers> createState() => _AddNumbersState();
}

class _AddNumbersState extends State<AddNumbers> {
  bool isLoading = true;

  List<Region> regions = [];
  List<SubRegion> subRegions = [];

  Region? selectedRegion;
  SubRegion? selectedSubRegion;
  Department? selectedDepartment;

  String phone = "";

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
        title: const Text("Add Numbers"),
      ),
      body: LoadingLayout(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                _getRegionFields(),
                const SizedBox(height: 10),
                _getDepartmentFields(),
                const SizedBox(height: 10),
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  hint: "Phone Number",
                  value: phone,
                  onChanged: (v) {
                    phone = v;
                  },
                ),
                SizedBox(height: 0.1 * getHeight(context)),
                ActionButton(
                  text: "Add This Contact",
                  onPressed: () async {
                    if (selectedDepartment == null) {
                      showToast("Please select a department");
                      return;
                    }
                    if (selectedRegion == null) {
                      showToast("Please select a region");
                      return;
                    }
                    if (phone.isEmpty) {
                      showToast("Please enter a phone number");
                      return;
                    }

                    isLoading = true;
                    setState(() {});

                    final res = await AdminManager.addNumber(
                      number: phone,
                      regionId: selectedRegion!.id,
                      subRegionId: selectedSubRegion!.id,
                      deptId: selectedDepartment!.id,
                    );

                    isLoading = false;
                    setState(() {});

                    if (res) {
                      phone = " ";
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDepartmentFields() {
    return FieldWrapper(
      child: FutureBuilder(
        future: AuthManager().getDepartments(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return DropdownButton<Department>(
              underline: Container(),
              hint: const Text("Select Department"),
              isExpanded: true,
              value: selectedDepartment,
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

              if (selectedRegion != null) {
                subRegions = selectedRegion!.subRegions;
              }

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
              setState(() {
                selectedSubRegion = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
