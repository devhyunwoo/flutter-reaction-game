import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reaction_check_app/feature/home/view/home_view.dart';
import 'package:reaction_check_app/feature/settings/view/settings_view.dart';
import 'package:reaction_check_app/feature/statistics/view/statistics_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: '/home', 
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/settings', 
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/statistics', 
        builder: (context, state) => const StatisticsView(),
      ),
    ]
  );
});