import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swaraksha/core/auth/application/auth.dart';

import 'package:swaraksha/core/issues/application/issues_manager.dart';
import 'package:swaraksha/dialogs/info_dialog.dart';
import 'package:swaraksha/helpers/location_helper.dart';
import 'package:swaraksha/models/department.dart';
import 'package:swaraksha/strings.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/field_wrapper.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import 'package:swaraksha/widgets/text_field.dart';
import 'package:swaraksha/colors.dart';
import 'package:swaraksha/globals.dart';

class AddIssuePage extends StatefulWidget {
  const AddIssuePage({super.key});

  @override
  State<AddIssuePage> createState() => _AddIssuePageState();
}

class _AddIssuePageState extends State<AddIssuePage> {
  Department? selectedDepartment;

  String title = "";
  String description = "";
  LatLng? location;
  bool isLoading = false;
  File? image;

  @override
  void initState() {
    LocationHelper.determinePosition().then((value) {
      if (value == null) {
        showToast("Couldn't get your location! Please try again later.");
        Navigator.pop(context);
      }

      location = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Issue Page"),
        actions: [
          IconButton(
            onPressed: () {
              InfoDialog.showInfoDialog(context, addIssueInfoString);
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: LoadingLayout(
        isLoading: isLoading,
        child: Stack(
          children: [
            Positioned.fill(
              child: _getBody(context),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1.0,
                      blurRadius: 5.0,
                      offset: Offset.zero,
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Center(
                  child: ActionButton(
                    text: "Add Issue",
                    onPressed: () async {
                      if (title.isEmpty) {
                        return showToast("Please enter title");
                      }
                      if (description.isEmpty) {
                        return showToast("Please enter description");
                      }
                      if (selectedDepartment == null) {
                        return showToast("Please select department");
                      }
                      if (location == null) {
                        Navigator.pop(context);
                        return showToast(
                            "Please enable location and try again!");
                      }

                      isLoading = true;
                      setState(() {});

                      await IssuesManager().addIssue(
                        title: title,
                        description: description,
                        department: selectedDepartment!.id,
                        location: location!,
                        images: image != null ? [image!] : [],
                      );

                      isLoading = false;
                      setState(() {});

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            CustomTextField(
              hint: "Title",
              onChanged: (v) {
                title = v;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hint: "Description",
              onChanged: (v) {
                description = v;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              onChanged: (v) {},
              hint: "Location (auto-detected)",
              value: location == null
                  ? "Fetching Location...  "
                  : "${location?.latitude}, ${location?.longitude}",
              isEditable: false,
            ),
            const SizedBox(height: 10),
            FieldWrapper(
              child: FutureBuilder(
                future: AuthManager().getDepartments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return DropdownButton<Department>(
                      underline: Container(),
                      value: selectedDepartment,
                      isExpanded: true,
                      hint: const Text("Select Department"),
                      items: snapshot.data!.map((e) {
                        return DropdownMenuItem<Department>(
                          value: e,
                          child: Text(e.name),
                        );
                      }).toList(),
                      onChanged: (e) {
                        selectedDepartment = e;
                        setState(() {});
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
            const Text(
              "Attach Image (optional)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            getAttachImageContainer(),
            SizedBox(
              height: 0.2 * getHeight(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAttachImageContainer() {
    if (image != null) {
      return Container(
        margin: const EdgeInsets.only(bottom: 30.0),
        height: 0.35 * getHeight(context),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  image = null;
                  setState(() {});
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          ImagePicker()
              .pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
          )
              .then((value) {
            if (value == null) {
              return;
            }
            // convert xfile to file
            image = File(value.path);
            setState(() {});
          });
        },
        child: Ink(
          height: 0.4 * getHeight(context),
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
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black.withOpacity(0.4),
                      size: 120,
                    ),
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
