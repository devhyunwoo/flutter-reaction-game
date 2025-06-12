import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/home_view_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final bgColor = homeState.isStart ? Colors.purple : Colors.red;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(title: const Text("Reaction Time Check")),
      body: GestureDetector(
        onTap: () {
          viewModel.touch();
        },
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(viewModel.displayText),
            ],
          ),
        ),
      ),
    );
  }
}
