import 'package:flutter/material.dart';
import 'package:swaraksha/core/admin/application/admin.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/department.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';
import 'package:swaraksha/widgets/text_field.dart';

class AddDepartmentPage extends StatefulWidget {
  const AddDepartmentPage({super.key});

  @override
  State<AddDepartmentPage> createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Departments"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              _getDepartmentFields(),
              const SizedBox(height: 20),
              CustomTextField(
                hint: "Department Name",
                value: name,
                onChanged: (v) {
                  name = v;
                },
              ),
              SizedBox(height: 0.2 * getHeight(context)),
              ActionButton(
                text: "Add Department",
                onPressed: () async {
                  if (name.isEmpty) {
                    showToast("Please enter department name");
                    return;
                  }
                  final res = await AdminManager.addDepartment(name.trim());
                  if (res) {
                    name = " ";
                    setState(() {});
                  }
                },
              ),
            ],
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
              hint: const Text("View Departments"),
              isExpanded: true,
              items: snapshot.data!.map((e) {
                return DropdownMenuItem<Department>(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (value) {},
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
}
