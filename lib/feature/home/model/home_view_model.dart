import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:reaction_check_app/services/preferences_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

import '../state/home_state.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  Timer? _delayTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  HomeState build() {
    ref.onDispose(() {
      _delayTimer?.cancel();
      _audioPlayer.dispose();
    });
    
    return const HomeState();
  }

  void startGame() {
    startCountdown();
  }

  void startCountdown() {
    _delayTimer?.cancel();

    state = state.copyWith(status: GameStatus.waiting);

    // 🎲 난이도에 따른 대기시간 설정
    final difficulty = ref.read(gameDifficultyProvider);
    final (minSeconds, maxSeconds) = ref.read(gameDifficultyProvider.notifier).getDifficultyRange();
    final randomSeconds = Random().nextInt(maxSeconds - minSeconds + 1) + minSeconds;
    
    _delayTimer = Timer(Duration(seconds: randomSeconds), () {
      _playSound('ready');
      _vibrate();
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
        final now = DateTime.now().millisecondsSinceEpoch;
        final reactionTime = now - state.startTimeStamp;
        
        // 🔊 성공 사운드 재생
        _playSound('success');
        _vibrate();
        
        // 📊 통계 데이터 업데이트
        ref.read(gameCountProvider.notifier).incrementCount();
        ref.read(averageScoreProvider.notifier).addScore(reactionTime);
        ref.read(topScoresProvider.notifier).addScore(reactionTime);
        
        // 🎯 bestScore 업데이트 (자동으로 최고점수 체크함)
        ref.read(bestScoreProvider.notifier).setBestScore(reactionTime);
        
        // 🏅 업적 체크
        _checkAchievements(reactionTime);
        
        state = state.copyWith(
          status: GameStatus.finished,
          reactionTime: reactionTime,
        );
        break;

      case GameStatus.waiting:
        _delayTimer?.cancel();
        _playSound('fail');
        _vibrate();
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

  // 🔊 사운드 재생 (시스템 햅틱으로 대체)
  Future<void> _playSound(String soundType) async {
    final soundEnabled = ref.read(soundEnabledProvider);
    if (!soundEnabled) return;

    try {
      // 시스템 햅틱 피드백 사용 (사운드 파일 대신)
      switch (soundType) {
        case 'ready':
          HapticFeedback.selectionClick();
          break;
        case 'success':
          HapticFeedback.lightImpact();
          break;
        case 'fail':
          HapticFeedback.heavyImpact();
          break;
      }
    } catch (e) {
      // 햅틱 재생 실패해도 게임은 계속
      print('Haptic feedback failed: $e');
    }
  }

  // 📳 진동
  Future<void> _vibrate() async {
    final vibrationEnabled = ref.read(vibrationEnabledProvider);
    if (!vibrationEnabled) return;

    try {
      if (await Vibration.hasVibrator() ?? false) {
        await Vibration.vibrate(duration: 100);
      }
    } catch (e) {
      print('Vibration failed: $e');
    }
  }

  // 🏅 업적 체크
  void _checkAchievements(int reactionTime) {
    try {
      final achievements = ref.read(achievementsProvider.notifier);
      final gameCount = ref.read(gameCountProvider);
      final bestScore = ref.read(bestScoreProvider);

      // 빠른 반응 업적들
      if (reactionTime <= 200) {
        achievements.unlockAchievement('lightning_fast');
      }
      if (reactionTime <= 150) {
        achievements.unlockAchievement('flash_master');
      }
      if (reactionTime <= 100) {
        achievements.unlockAchievement('superhuman');
      }

      // 게임 횟수 업적들 (안전한 체크)
      if (gameCount >= 10) {
        achievements.unlockAchievement('dedicated_player');
      }
      if (gameCount >= 50) {
        achievements.unlockAchievement('reaction_veteran');
      }
      if (gameCount >= 100) {
        achievements.unlockAchievement('thousand_touches');
      }

      // 기록 개선 업적 (null 안전성 체크)
      if (bestScore != null && bestScore > 0 && reactionTime < bestScore) {
        achievements.unlockAchievement('new_record');
      }
    } catch (e) {
      print('Achievement check failed: $e');
    }
  }
}
