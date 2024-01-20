import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swaraksha/colors.dart';

import 'package:swaraksha/core/auth/application/auth.dart';
import 'package:swaraksha/core/auth/presentation/department_page.dart';
import 'package:swaraksha/core/auth/presentation/region_page.dart';
import 'package:swaraksha/core/auth/presentation/signup_page.dart';
import 'package:swaraksha/globals.dart';
import 'package:swaraksha/widgets/action_button.dart';
import 'package:swaraksha/widgets/loading_layout.dart';
import 'package:swaraksha/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
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
                height: 0.5 * getHeight(context),
                width: double.infinity,
                color: cardColor,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/login.svg",
                      height: 0.3 * getHeight(context),
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 0.05 * getHeight(context)),
              _getForm(),
              SizedBox(height: 0.05 * getHeight(context)),
            ],
          ),
        ),
      ),
    );
  }

  _getForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Log in",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Welcome back to swaraksha",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _phoneController,
            hint: "Phone Number",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            hint: "Password",
            isPassword: true,
          ),
          const SizedBox(height: 20),
          ActionButton(
            text: "Login",
            onPressed: onLoginPressed,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => navigateTo(const SignUpPage(), context),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a user?"),
                SizedBox(width: 5),
                Text(
                  "Sign Up",
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

  void onLoginPressed() async {
    if (_passwordController.text.isEmpty) {
      return showSnackBar("Input your password", context);
    }
    if (_phoneController.text.length != 10) {
      return showSnackBar("Input a valid number", context);
    }

    isLoading = true;
    setState(() {});

    final res = await AuthManager().login(
      _phoneController.text,
      _passwordController.text,
    );

    isLoading = false;
    setState(() {});

    if (res != null && mounted) {
      if (res.userType == "user") {
        navigateTo(const RegionPage(), context);
      } else {
        navigateTo(const DepartmentPage(), context);
      }
    }
  }
}
