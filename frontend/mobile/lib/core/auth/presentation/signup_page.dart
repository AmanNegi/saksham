import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swaraksha/colors.dart';

import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/core/auth/presentation/login_page.dart';
import 'package:swaraksha/core/auth/presentation/otp_page.dart';
import 'package:swaraksha/globals.dart';

import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import 'package:swaraksha/widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  StreamSubscription? verificationIdSubs;
  String name = "", phone = " ", password = "", confirmPassword = "";
  bool isLoading = false;

  @override
  void dispose() {
    if (verificationIdSubs != null) {
      verificationIdSubs!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingLayout(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 0.4 * getHeight(context),
                width: double.infinity,
                color: cardColor,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/signup.svg",
                      height: 0.3 * getHeight(context),
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 0.025 * getHeight(context)),
              _getForm(),
            ],
          ),
        ),
      ),
    );
  }

  _getForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Welcome to swaraksha. Let's get started!",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hint: "Enter your name",
            onChanged: (value) {
              name = value;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hint: "Enter your phone number",
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              phone = value;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hint: "Enter your password",
            isPassword: true,
            onChanged: (value) {
              password = value;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hint: "Confirm your password",
            isPassword: true,
            onChanged: (value) {
              confirmPassword = value;
            },
          ),
          const SizedBox(height: 20),
          ActionButton(
            onPressed: () async {
              if (!validateFields()) {
                return;
              }

              isLoading = true;
              setState(() {});

              final manager = AuthManager();
              verificationIdSubs = manager.verificationIdController.stream
                  .listen((verificationId) async {
                if (verificationId != null) {
                  if (verificationIdSubs != null) {
                    verificationIdSubs!.cancel();
                    verificationIdSubs = null;
                  }
                  isLoading = false;
                  setState(() {});
                  navigateTo(
                    OTPPage(
                      verificationId: verificationId,
                      name: name,
                      phone: phone,
                      password: password,
                    ),
                    context,
                  );
                }
              });
              await manager.sendOTP(phone);
            },
            text: "SignUp",
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              navigateTo(const LoginPage(), context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                SizedBox(width: 5),
                Text(
                  "Log in",
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool validateFields() {
    if (name.isEmpty) {
      showSnackBar("Please enter your name", context);
      return false;
    }
    if (phone.isEmpty) {
      showSnackBar("Please enter your phone number", context);
      return false;
    }
    if (password.isEmpty) {
      showSnackBar("Please enter your password", context);
      return false;
    }
    if (confirmPassword.isEmpty) {
      showSnackBar("Please confirm your password", context);
      return false;
    }
    if (password != confirmPassword) {
      showSnackBar("Passwords do not match", context);
      return false;
    }

    return true;
  }
}
