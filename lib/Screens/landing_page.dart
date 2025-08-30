// lib/screens/landing_page.dart
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration_page.dart';
import 'main_app_pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void _markLandingPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenLanding', true);
  }

  void _goToRegistration(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const RegistrationPage()),
    );
  }

  void _goToApp(BuildContext context) {
    //_markLandingPage(context);
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const MainAppPages()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  'Welcome in Tripper',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              CupertinoButton.tinted(
                onPressed: () => _goToRegistration(context),
                child: const Text('Registration'),
              ),
              const SizedBox(height: 12),
              CupertinoButton(
                onPressed: () => _goToApp(context),
                child: const Text('Go to the app'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}