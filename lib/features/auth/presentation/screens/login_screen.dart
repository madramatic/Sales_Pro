import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sales_pro/features/auth/presentation/providers/all_information_state.dart';
import 'package:sales_pro/features/auth/presentation/providers/login_state.dart';
import 'package:sales_pro/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:sales_pro/shared/presentation/widgets/app_checkbox.dart';
import 'package:sales_pro/shared/presentation/widgets/custom_snackbar.dart';
import 'package:sales_pro/shared/presentation/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginStateNotifierProvider, (previous, next) {
      if (next is LoginSuccess) {
        CustomSnackbar.showSuccess(
          context,
          'Welcome back, ${next.user.fullName}!',
        );

        ref.read(currentUserProvider.notifier).state = next.user;

        ref
            .read(allInformationStateNotifierProvider.notifier)
            .getAllInformation();
      } else if (next is LoginFailure) {
        CustomSnackbar.showError(context, next.message);
      }
    });

    ref.listen<AllInformationState>(allInformationStateNotifierProvider,
        (previous, next) {
      if (next is AllInformationSuccess) {
        context.go('/maps');
      } else if (next is AllInformationFailure) {
        CustomSnackbar.showError(
            context, 'Failed to load app data: ${next.message}');
        context.go('/maps');
      }
    });

    final loginState = ref.watch(loginStateNotifierProvider);
    final allInformationState = ref.watch(allInformationStateNotifierProvider);

    final isLoading = loginState is LoginLoading ||
        allInformationState is AllInformationLoading;
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
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'To get started, enter email address and password.',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AuthTextField(
                    controller: _emailController,
                    hint: 'Your Email',
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
                    controller: _passwordController,
                    hint: 'Password',
                    obscureText: !_isPasswordVisible,
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
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: 'LOGIN',
                    isLoading: isLoading,
                    onPressed: _handleLogin,
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

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      ref.read(loginStateNotifierProvider.notifier).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }
}
