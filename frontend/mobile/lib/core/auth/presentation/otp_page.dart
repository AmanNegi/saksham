import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:swaraksha/colors.dart';
import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/core/auth/presentation/department_page.dart';
import 'package:swaraksha/core/auth/presentation/region_page.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/back_layout.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import 'package:swaraksha/widgets/text_field.dart';

class OTPPage extends StatefulWidget {
  final String verificationId;
  final String phone;
  final String password;
  final String name;
  const OTPPage({
    super.key,
    required this.verificationId,
    required this.phone,
    required this.password,
    required this.name,
  });

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingLayout(
        isLoading: isLoading,
        child: BackLayout(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 0.5 * getHeight(context),
                  width: double.infinity,
                  color: cardColor,
                  child: Column(
                    children: [
                      const Spacer(),
                      SvgPicture.asset(
                        "assets/otp.svg",
                        height: 0.3 * getHeight(context),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 0.025 * getHeight(context)),
                _getForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _getForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0.05 * getHeight(context)),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Verify with OTP",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Please input the OTP sent to your registered mobile number",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: codeController,
            hint: "Enter your OTP",
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 0.05 * getHeight(context)),
          ActionButton(
            text: "Continue",
            onPressed: onPressedVerify,
          ),
          SizedBox(height: 0.1 * getHeight(context)),
        ],
      ),
    );
  }

  void onPressedVerify() async {
    if (codeController.text.trim().isEmpty) {
      showToast("Please enter OTP");
      return;
    }

    isLoading = true;
    setState(() {});

    bool res = await AuthManager().verifyOTP(
      otp: codeController.text.trim(),
      verificationId: widget.verificationId,
      name: widget.name,
      phone: widget.phone,
      password: widget.password,
    );

    isLoading = false;
    setState(() {});

    if (res && appState.value.userType == "user" && mounted) {
      navigateTo(const RegionPage(), context);
    } else if (res && appState.value.userType == "admin" && mounted) {
      navigateTo(const DepartmentPage(), context);
    }
  }
}
