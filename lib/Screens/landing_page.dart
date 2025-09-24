// lib/screens/landing_page.dart
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripper/Screens/registration_page.dart';
import 'package:tripper/data/trip_service.dart';
import 'auth_gate.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TripService tripService = TripService();

  void _goToRegistration(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 34, 10, 26),
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.3),
                  width: 1.2,
                ),
                gradient: LinearGradient(
                  colors: [
                    CupertinoColors.white.withOpacity(0.25),
                    CupertinoColors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(child: RegistrationPage()),
            ),
          ),
        );
      },
    );
  }

  Future<void> _goToApp(BuildContext context) async {
    await tripService.onAnanym();
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => const AuthGate()));
    _markLandingPageSeen();
  }

  void _markLandingPageSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenLanding', true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6D5DF6),
                  Color(0xFF4AC0E0),
                  Color(0xFF41E09E),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
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
        ],
      ),
    );
  }
}
