import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;

import 'package:swaraksha/constants.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/models/issue.dart';
import 'package:uuid/uuid.dart';

class IssuesManager {
  Future<List<Issue>> getUserIssues() async {
    final url = Uri.parse("$API_URL/issues/list/${appState.value.uid}");
    final response = await http.get(url);

    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("Issues: ${response.body}");
      List<Issue> issues = [];
      for (var item in json.decode(response.body)) {
        issues.add(Issue.fromMap(item));
      }

      return issues;
    } else {
      showToast("Error while fetching issues");
      return [];
    }
  }

  Future<bool> updateIssueStatus(String issueId, String status) async {
    final response = await http.post(
      Uri.parse("$API_URL/issues/resolve/$status"),
      body: {
        "issueId": issueId,
        "userId": appState.value.uid!,
      },
    );
  
    debugPrint("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      showToast("Issue marked as $status");
      return true;
    } else {
      showToast("Error while marking issue as $status");
      return false;
    }
  }

  Future<List<Issue>> getIssuesByDepartment() async {
    print("Department ID: ${appState.value.departmentId}");
    final url = Uri.parse(
        "$API_URL/issues/department/list/${appState.value.departmentId}");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      debugPrint("Issues: ${response.body}");
      List<Issue> issues = [];
      for (var item in json.decode(response.body)) {
        issues.add(Issue.fromMap(item));
      }

      return issues;
    } else {
      showToast("Error while fetching issues");
      return [];
    }
  }

  Future<bool> addIssue({
    required String title,
    required String description,
    required String department,
    required LatLng location,
    required List<File> images,
  }) async {
    if (appState.value.uid == null) {
      showToast("Please login to add an issue");
      return false;
    }

    String? imageUrl;
    if (images.isNotEmpty) {
      imageUrl = await uploadImage(
        const Uuid().v1(),
        appState.value.uid!,
        images[0],
      );
    }

    final url = Uri.parse("$API_URL/issues/create/");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'title': title,
        'description': description,
        'status': 'open',
        'department': department,
        'location': {
          'type': 'Point',
          'coordinates': [
            location.latitude,
            location.longitude,
          ],
        },
        'images': imageUrl == null ? [] : [imageUrl],
        'issuedBy': appState.value.uid,
      }),
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      showToast("Issue added successfully");
      return true;
    } else {
      showToast(
          "An error occured while adding issue. Check if you have a ticket opened already in the same department.");
      return false;
    }
  }

  Future<String?> uploadImage(String itemId, String userId, File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      String fileExtension = file.path.split('.').last;

      Reference ref =
          storage.ref().child("issues/$userId/$itemId.$fileExtension");
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
      showToast("An error occured while uploading image. Try again!");
      return null;
    }
  }
}
