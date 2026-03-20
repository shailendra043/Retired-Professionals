import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'state/app_state.dart';
import 'screens/auth/login_screen.dart';
import 'screens/user/profile_setup_screen.dart';
import 'screens/user/user_dashboard.dart';
import 'screens/client/client_dashboard.dart';
import 'screens/client/expert_search_screen.dart';
import 'screens/client/expert_profile_screen.dart';

void main() {
  runApp(const RetiredProfessionalsApp());
}

final AppState _appState = AppState();

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    // User Routes
    GoRoute(
      path: '/professional/dashboard',
      builder: (context, state) => const UserDashboard(),
    ),
    GoRoute(
      path: '/professional/setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
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
  ],
);

class RetiredProfessionalsApp extends StatelessWidget {
  const RetiredProfessionalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _appState,
      child: MaterialApp.router(
        title: 'Retired Professionals',
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
