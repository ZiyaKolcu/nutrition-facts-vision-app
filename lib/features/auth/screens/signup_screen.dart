import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/localization/locale_provider.dart';
import '../../../core/theme/theme_extensions.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import 'signin_screen.dart';
import '../../profile_setup/views/profile_setup_view.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayName = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    if (_pass.text != _confirm.text) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.passwordsDoNotMatch)));
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
        ).showSnackBar(SnackBar(content: Text(e.message ?? l10n.signUpFailed)));
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
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signUp)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AuthHeader(
                  title: l10n.createAccount,
                  subtitle: l10n.createAccountSubtitle,
                ),
                const SizedBox(height: 32),
                AuthTextField(
                  label: l10n.name,
                  controller: _displayName,
                  validator: (v) =>
                      v!.isEmpty ? l10n.pleaseEnterDisplayName : null,
                ),
                const SizedBox(height: 16),
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
                  validator: (v) =>
                      v!.length < 6 ? l10n.minimumCharacters : null,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  label: l10n.confirmPassword,
                  obscureText: true,
                  controller: _confirm,
                  validator: (v) =>
                      v!.isEmpty ? l10n.pleaseConfirmPassword : null,
                ),
                const SizedBox(height: 32),
                AuthButton(text: l10n.signUp, onPressed: _signUp),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                  ),
                  child: Text(l10n.alreadyHaveAccount),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.language,
                      size: 20,
                      color: context.colors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colors.outline),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: locale.languageCode,
                          isDense: true,
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(l10n.english),
                            ),
                            DropdownMenuItem(
                              value: 'tr',
                              child: Text(l10n.turkish),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(localeProvider.notifier)
                                  .setLocale(Locale(value));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
