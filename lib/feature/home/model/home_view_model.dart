import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/home_state.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  Timer? _delayTimer;

  @override
  HomeState build() {
    ref.onDispose(() {
      _delayTimer?.cancel();
    });
    
    return const HomeState();
  }

  void startGame() {
    startCountdown();
  }

  void startCountdown() {
    _delayTimer?.cancel();

    state = state.copyWith(status: GameStatus.waiting);

    final randomSeconds = Random().nextInt(5) + 2;
    _delayTimer = Timer(Duration(seconds: randomSeconds), () {
      state = state.copyWith(
        status: GameStatus.ready,
        startTimeStamp: DateTime
            .now()
            .millisecondsSinceEpoch,
      );
    });
  }

  void touch() {
    switch (state.status) {
      case GameStatus.ready:
        final now = DateTime
            .now()
            .millisecondsSinceEpoch;
        final reactionTime = now - state.startTimeStamp;
        state = state.copyWith(
          status: GameStatus.finished,
          reactionTime: reactionTime,
        );
        break;

      case GameStatus.waiting:
        _delayTimer?.cancel();
        state = state.copyWith(status: GameStatus.preClicked);
        break;

      case GameStatus.finished:
      case GameStatus.preClicked:
        state = state.copyWith(
          status: GameStatus.initial,
          reactionTime: 0,
          startTimeStamp: 0,
        );
        break;
        
      case GameStatus.initial:
        break;
    }
  }

  String get displayText => state.status.getText(state.reactionTime);

  Color get backgroundColor => state.status.backgroundColor;
}
