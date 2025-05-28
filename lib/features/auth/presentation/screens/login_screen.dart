import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_pro/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:sales_pro/shared/presentation/widgets/app_checkbox.dart';
import 'package:sales_pro/shared/presentation/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  const Icon(
                    Icons.login,
                    size: 120,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Continue with email',
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'To get started, enter email address and password.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  AuthTextField(
                    controller: usernameController,
                    hintText: 'Your Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email cannot be empty';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  AuthTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: !_isPasswordVisible,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.colorScheme.onSecondary,
                        size: 24,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      AppCheckbox(
                        value: true,
                        color: theme.colorScheme.onPrimary,
                        onChanged: (newValue) {},
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Remember me',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: 'LOGIN',
                    onPressed: () => context.go('/maps'),
                    icon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.push('/forgot_password');
                      },
                      child: Text('Forgot Password?',
                          style: theme.textTheme.bodyLarge),
                    ),
                  ),
                  const SizedBox(height: 120),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(''));
                      },
                      child: Text(
                        'Privacy & Terms',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
