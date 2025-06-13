import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reaction_check_app/services/preferences_service.dart';

import '../model/home_view_model.dart';
import '../state/home_state.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final bestScore = ref.watch(bestScoreProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("반응속도 테스트", style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,),
      body: _buildBody(homeState, viewModel, bestScore),
    );
  }

  Widget _buildBody(HomeState homeState, HomeViewModel viewModel, int? bestScore) {
    // 🎯 initial 상태일 때만 게임 시작 화면 (조건 단순화!)
    if (homeState.status == GameStatus.initial) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '반응속도 테스트',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                '초록색 화면이 나타나면\n최대한 빠르게 터치하세요!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => viewModel.startGame(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('게임 시작', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      );
    }

    if (homeState.status == GameStatus.finished) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: viewModel.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // 🎯 bestScore 표시 (null이 아닐 때만)
              if (bestScore != null) ...[
                Text(
                  '🏆 최고 기록: ${bestScore}ms',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Text(
                homeState.status.getText(homeState.reactionTime),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: viewModel.touch,
                child: const Text('다시 시작'),
              ),
            ],
          ),
        ),
      );
    }
    // 🎯 게임 진행 중일 때는 전체 터치 영역
    return GestureDetector(
      onTap: () => viewModel.touch(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: homeState.status.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                homeState.status.getText(homeState.reactionTime),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (homeState.status == GameStatus.finished ||
                  homeState.status == GameStatus.preClicked) ...[
                const SizedBox(height: 20),
                const Text(
                  '화면을 터치하여 다시 시작',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
