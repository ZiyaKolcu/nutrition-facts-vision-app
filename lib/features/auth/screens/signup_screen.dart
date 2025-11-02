import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import 'signin_screen.dart';
import '../../profile_setup/views/profile_setup_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayName = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (_pass.text != _confirm.text) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      }
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _email.text.trim(),
            password: _pass.text.trim(),
          );

      await userCredential.user?.updateDisplayName(_displayName.text.trim());
      await userCredential.user?.reload();

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ProfileSetupView()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Sign-up failed')));
      }
    }
  }

  @override
  void dispose() {
    _displayName.dispose();
    _email.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AuthHeader(
                  title: 'Create account',
                  subtitle: 'Quick & secure',
                ),
                const SizedBox(height: 32),
                AuthTextField(
                  label: 'Name',
                  controller: _displayName,
                  validator: (v) =>
                      v!.isEmpty ? 'Please enter your display name' : null,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  label: 'Email',
                  controller: _email,
                  validator: (v) =>
                      v!.isEmpty ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  label: 'Password',
                  obscureText: true,
                  controller: _pass,
                  validator: (v) =>
                      v!.length < 6 ? 'Minimum 6 characters' : null,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  label: 'Confirm password',
                  obscureText: true,
                  controller: _confirm,
                  validator: (v) =>
                      v!.isEmpty ? 'Please confirm your password' : null,
                ),
                const SizedBox(height: 32),
                AuthButton(text: 'Create Account', onPressed: _signUp),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                  ),
                  child: const Text('Already have an account? Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
