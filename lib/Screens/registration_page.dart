// lib/screens/registration_page.dart
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:tripper/data/trip_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLogin = false;
  final TripService tripService = TripService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    tripService.onRegister(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    Navigator.pop(context);
  }

  Widget _input(
    String placeholder,
    TextEditingController controller, {
    bool obscure = false,
    TextInputAction action = TextInputAction.next,
  }) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(color: CupertinoColors.transparent),
        ),
        color: CupertinoColors.transparent,
      ),
      controller: controller,
      placeholder: placeholder,
      obscureText: obscure,
      textInputAction: action,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _pageName(String name) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
          width: MediaQuery.of(context).size.width * 0.5,
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
          child: Center(child: Text(name)),
        ),
      ),
    );
  }

  Widget _field(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
          child: Center(child: child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _pageName("Registration"),
          const SizedBox(height: 24),
          _field(_input('Name', _nameController)),
          _field(_input('Email', _emailController)),
          _field(
            _input(
              'Password',
              _passwordController,
              obscure: true,
              action: TextInputAction.done,
            ),
          ),
          const SizedBox(height: 24),
          CupertinoButton.filled(
            onPressed: () => _register(),
            child: const Text('Sign In'),
          ),
          const SizedBox(height: 12),
          /*CupertinoButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
                child: const Text('Back'),
              ),*/
        ],
      ),
    );
  }
}
