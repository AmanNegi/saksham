import "dart:async";
import "dart:convert";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:swaraksha/constants.dart";

import "package:swaraksha/data/app_state.dart";
import "package:swaraksha/globals.dart";
import "package:http/http.dart" as http;
import "package:swaraksha/models/department.dart";
import "package:swaraksha/models/region.dart";
import "package:swaraksha/models/user.dart";

class AuthManager {
  final verificationIdController = StreamController<String?>.broadcast();

  Future<List<Region>> getRegions() async {
    final res = await http.get(
      Uri.parse("$API_URL/regions"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    debugPrint(res.body);

    if (res.statusCode == 200) {
      List<Region> regions = [];
      for (var item in json.decode(res.body)) {
        regions.add(Region.fromMap(item));
      }
      return regions;
    } else {
      debugPrint("Error while fetching regions: ${res.body}");
      showToast(res.body);
      return [];
    }
  }

  Future<List<Department>> getDepartments() async {
    final res = await http.get(
      Uri.parse("$API_URL/departments"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      List<Department> departments = [];
      for (var item in json.decode(res.body)) {
        departments.add(Department.fromMap(item));
      }
      return departments;
    } else {
      debugPrint("Error while fetching departments: ${res.body}");
      showToast(res.body);
      return [];
    }
  }

  Future<bool> verifyOTP({
    required String otp,
    required String verificationId,
    required String name,
    required String phone,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId.trim(),
      smsCode: otp.trim(),
    );

    try {
      UserCredential result = await auth.signInWithCredential(credential);

      User? user = result.user;

      if (user != null) {
        // make register request to backend
        final data = await AuthManager().register(
          name.trim(),
          phone.trim(),
          password.trim(),
        );

        print(data);
        if (data == null) {
          showToast("Error while registering");
          return false;
        }

        AppUser appUser = AppUser.fromJson(data.toJson());

        // save to local storage and go to home page
        GetIt.instance<AppCache>().updateAppCache(
          AppState(
            isLoggedIn: true,
            name: appUser.name,
            phone: appUser.phone,
            uid: appUser.id,
            userType: appUser.userType,
            department: "",
          ),
        );

        showToast("Verification Successfull");
        return true;
      } else {
        showToast("Error while verifying");
        return false;
      }
    } on FirebaseAuthException catch (error, _) {
      debugPrint("FirebaseAuthException: $error");
      showToast(error.message.toString());
      return false;
    } catch (e) {
      debugPrint(e.toString());
      showToast(e.toString());
      return false;
    }
  }

  Future<void> sendOTP(String phone) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: "+91${phone.trim()}",
      timeout: const Duration(seconds: 120),
      verificationCompleted: (AuthCredential credential) async {
        debugPrint("Verification Completed");
      },
      verificationFailed: (exception) {
        _verificationError(exception.toString());
      },
      codeSent: (String verificationId, _) {
        verificationIdController.add(verificationId);
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<AppUser?> register(String name, String phone, String password) async {
    final res = await http.post(
      Uri.parse("$API_URL/auth/signUp"),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "name": name.trim(),
        "phone": phone.trim(),
        "password": password.trim(),
      }),
    );

    // if user is logged in we consider his number as verified
    if (res.statusCode == 200) {
      AppUser user = AppUser.fromJson(res.body);
      showToast("Login Successful");
      GetIt.instance<AppCache>().updateAppCache(
        AppState(
          isLoggedIn: true,
          name: user.name,
          phone: phone,
          uid: user.id,
          department: "",
          userType: user.userType,
        ),
      );
      return user;
    } else {
      debugPrint("Error while adding user to backend: ${res.body}");
      showToast(res.body);
      return null;
    }
  }

  Future<AppUser?> login(String phone, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$API_URL/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "phone": phone,
          "password": password,
        }),
      );

      // if user is logged in we consider his number as verified
      if (res.statusCode == 200) {
        AppUser user = AppUser.fromJson(res.body);
        showToast("Login Successful");
        GetIt.instance<AppCache>().updateAppCache(
          AppState(
            isLoggedIn: true,
            name: user.name,
            phone: phone,
            uid: user.id,
            department: "",
            userType: user.userType,
          ),
        );
        return user;
      } else {
        showToast(res.body);
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      showToast(e.toString());
      return null;
    }
  }

  void _verificationError(String error) {
    debugPrint("Verification Error $error");
    showToast("Verification Error $error");
  }
}
