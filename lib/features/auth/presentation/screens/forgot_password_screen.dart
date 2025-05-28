import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_pro/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:sales_pro/shared/presentation/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  const Icon(
                    Icons.password,
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
                    'Forgot your password? \nNo problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  AuthTextField(
                    controller: emailController,
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
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'Send Reset Link',
                    onPressed: () => context.pop(),
                    icon: Icons.arrow_forward_ios_rounded,
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'Return',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
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
