// lib/main.dart
import 'package:flutter/cupertino.dart';
import 'landing_page.dart';
import 'main_app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool seenLanding = prefs.getBool('seenLanding') ?? false;

  runApp(MyApp(seenLanding: seenLanding));
}

class MyApp extends StatelessWidget {
  final bool seenLanding;
  const MyApp({super.key, required this.seenLanding});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Tripper',
      home: seenLanding ? MainAppPages() : const LandingPage(),
    );
  }
}