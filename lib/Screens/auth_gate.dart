import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_app_pages.dart';
import 'registration_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator(radius: 16)),
          );
        }

        if (!snapshot.hasData) {
          return const RegistrationPage();
        }

        return const MainAppPages();
      },
    );
  }
}