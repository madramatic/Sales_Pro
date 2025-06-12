import 'package:go_router/go_router.dart';
import 'package:sales_pro/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:sales_pro/features/chat/presentation/screens/chat_screen.dart';
import 'package:sales_pro/features/map/presentation/screens/maps_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgot_password',
      name: 'forgot_password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/maps',
      name: 'maps',
      builder: (context, state) => const MapsScreen(),
    ),
    GoRoute(
      path: '/chat',
      name: 'chat',
      builder: (context, state) => const ChatScreen(),
    ),
  ],
);
