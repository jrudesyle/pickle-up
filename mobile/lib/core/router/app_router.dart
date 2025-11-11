import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/courts/screens/courts_screen.dart';
import '../../features/courts/screens/court_detail_screen.dart';
import '../../features/ladders/screens/ladders_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../auth/auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/courts',
    redirect: (context, state) {
      final isAuth = authState.value != null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isAuth && !isAuthRoute) {
        return '/auth/login';
      }

      if (isAuth && isAuthRoute) {
        return '/courts';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/courts',
        builder: (context, state) => const CourtsScreen(),
      ),
      GoRoute(
        path: '/courts/:id',
        builder: (context, state) {
          final courtId = state.pathParameters['id']!;
          return CourtDetailScreen(courtId: courtId);
        },
      ),
      GoRoute(
        path: '/ladders',
        builder: (context, state) => const LaddersScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});
