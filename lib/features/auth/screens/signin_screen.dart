import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

      // Giriş başarılı olduğunda AuthGate'e yönlendir
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Sign-in failed')));
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
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthHeader(
                title: 'Welcome back',
                subtitle: 'Sign in to continue',
              ),
              const SizedBox(height: 32),
              AuthTextField(
                label: 'Email',
                controller: _email,
                validator: (v) => v!.isEmpty ? 'Please enter your email' : null,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Password',
                obscureText: true,
                controller: _pass,
                validator: (v) =>
                    v!.isEmpty ? 'Please enter your password' : null,
              ),
              const SizedBox(height: 32),
              AuthButton(text: 'Sign In', onPressed: _signIn),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
