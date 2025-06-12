import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/home_state.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  Timer? _delayTimer;

  @override
  HomeState build() {
    start();
    return const HomeState();
  }

  void start() {
    _delayTimer?.cancel();
    final randomDelay = Random().nextInt(10);
    _delayTimer = Timer(Duration(seconds: randomDelay), () {
      state = state.copyWith(
        isStart: true,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      );
    });
  }

  String get displayText {
    return switch ((state.isStart, state.isEnd)) {
      (true, false) => '시작! 터치해라!',
      (false, true) => '오 빠른데?ㅋ\n${state.timeStamp}ms',
      _ => '시작하면 해라 ㅋ',
    };
  }

  void touch() {
    if (state.isStart) {
      final timeStamp = DateTime.now().millisecondsSinceEpoch - state.timeStamp;
      state = state.copyWith(
        isStart: false,
        isEnd: true,
        timeStamp: timeStamp,
      );
    } else {
      _delayTimer?.cancel();
    }
  }
}
