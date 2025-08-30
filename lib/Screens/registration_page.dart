// lib/screens/registration_page.dart
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_app_pages.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _markLandingPage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenLanding', true);
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    //_markLandingPage(context);
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (_) => const MainAppPages()),
    );
  }

  Widget _input(String placeholder, TextEditingController controller,
      {bool obscure = true, TextInputAction action = TextInputAction.next}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        obscureText: obscure,
        textInputAction: action,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const Text(
                'Registration',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              _input('Name', _nameController),
              _input('Email', _emailController, action: TextInputAction.next),
              _input('Password', _passwordController, obscure: true, action: TextInputAction.done),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CupertinoActivityIndicator()
                    : const Text('Sign In'),
              ),
              const SizedBox(height: 12),
              CupertinoButton(
                onPressed: _isSubmitting ? null : () => {
                  Navigator.of(context).pop(),
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}