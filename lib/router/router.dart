import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reaction_check_app/feature/home/view/home_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(path: '/home', builder: (context, state) => const HomeView())
    ]
  );
});