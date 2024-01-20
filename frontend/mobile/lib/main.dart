import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swaraksha/core/auth/presentation/login_page.dart';
import 'package:swaraksha/core/home/presentation/user/dashboard_page.dart';
import 'package:swaraksha/core/notification/application/notification_manager.dart';
import 'package:swaraksha/data/app_state.dart';
import 'package:swaraksha/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final getIt = GetIt.instance;

  getIt.registerSingleton<AppCache>(AppCache());
  getIt.registerSingleton<NotificationManager>(NotificationManager());

  await getIt<AppCache>().getDataFromDevice();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwayamRaksha',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        // useMaterial3: false,
      ),
      // home: const MyIssuesPage(),
      home: getHome(),
      // home: const AdminControlPage(),
      // home: const OTPPage(
      //   name: "Admin",
      //   password: "",
      //    phone: "",
      //    verificationId: "",
      // ),
    );
  }

  Widget getHome() {
    if (appState.value.isLoggedIn) {
      return const DashboardPage();
    }
    return const LoginPage();
  }
}
