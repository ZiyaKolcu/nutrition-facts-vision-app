import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import 'signup_screen.dart';
import 'auth_gate.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? l10n.signInFailed)));
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.signIn)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthHeader(
                title: l10n.welcomeBack,
                subtitle: l10n.signInSubtitle,
              ),
              const SizedBox(height: 32),
              AuthTextField(
                label: l10n.email,
                controller: _email,
                validator: (v) => v!.isEmpty ? l10n.pleaseEnterEmail : null,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: l10n.password,
                obscureText: true,
                controller: _pass,
                validator: (v) => v!.isEmpty ? l10n.pleaseEnterPassword : null,
              ),
              const SizedBox(height: 32),
              AuthButton(text: l10n.signIn, onPressed: _signIn),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
                child: Text(l10n.dontHaveAccount),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
