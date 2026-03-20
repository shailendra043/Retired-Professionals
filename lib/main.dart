import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
// Import screens (to be created)
// auth
import 'screens/auth/login_screen.dart';
// user
import 'screens/user/profile_setup_screen.dart';
import 'screens/user/user_dashboard.dart';
// client
import 'screens/client/client_dashboard.dart';
import 'screens/client/expert_search_screen.dart';
import 'screens/client/expert_profile_screen.dart';
// admin
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/verification_screen.dart';

void main() {
  runApp(const RetiredProfessionalsApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    // User Routes
    GoRoute(
      path: '/user/dashboard',
      builder: (context, state) => const UserDashboard(),
    ),
    GoRoute(
      path: '/user/setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    // Client Routes
    GoRoute(
      path: '/client/dashboard',
      builder: (context, state) => const ClientDashboard(),
    ),
    GoRoute(
      path: '/client/search',
      builder: (context, state) => const ExpertSearchScreen(),
    ),
    GoRoute(
      path: '/client/expert/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ExpertProfileScreen(expertId: id);
      },
    ),
    // Admin Routes
    GoRoute(
      path: '/admin/dashboard',
      builder: (context, state) => const AdminDashboard(),
    ),
    GoRoute(
      path: '/admin/verification',
      builder: (context, state) => const VerificationScreen(),
    ),
  ],
);

class RetiredProfessionalsApp extends StatelessWidget {
  const RetiredProfessionalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Retired Professionals',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
