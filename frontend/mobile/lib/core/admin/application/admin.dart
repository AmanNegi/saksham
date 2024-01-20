import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:swaraksha/constants.dart";
import "package:swaraksha/globals.dart";

class AdminManager {
  static Future<bool> addDepartment(String name) async {
    final url = Uri.parse("$API_URL/departments/");
    final res = await http.post(url, body: {
      "name": name.trim(),
    });

    debugPrint(res.body);

    if (res.statusCode == 200) {
      showToast("Department added successfully");
      return true;
    } else {
      showToast("Failed to add department");
      return false;
    }
  }

  static Future<bool> addNumber({
    required String number,
    required String regionId,
    required String subRegionId,
    required String deptId,
  }) async {
    final url = Uri.parse("$API_URL/number/add");
    final res = await http.post(url, body: {
      "number": number.trim(),
      "regionId": regionId.trim(),
      "departmentId": deptId.trim(),
      "subRegionId": subRegionId.trim(),
    });

    debugPrint(res.body);

    if (res.statusCode == 200) {
      showToast("Number added successfully");
      return true;
    } else {
      showToast("Failed to add number");
      return false;
    }
  }

  static Future<bool> addSubRegion(
      String regionName, String subRegionName) async {
    final url = Uri.parse("$API_URL/regions/addSubRegion");
    final res = await http.post(url, body: {
      "regionName": regionName,
      "subRegionName": subRegionName,
    });

    debugPrint(res.body);

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getNumbersForRegion(String regionId) async {
    final url = Uri.parse("$API_URL/number/$regionId");
    final res = await http.get(url);
    return res.body;
  }
}
