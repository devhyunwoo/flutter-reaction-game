import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_service.g.dart'; // 자동 생성될 파일

// SharedPreferences 인스턴스 제공
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(); // main에서 override 할 거예요
}

// 최고 점수 관리 클래스
@riverpod
class BestScore extends _$BestScore {
  static const String _key = 'best_score';

  @override
  int? build() {
    try {
      final prefs = ref.watch(sharedPreferencesProvider);
      final score = prefs.getInt(_key);
      return (score != null && score > 0) ? score : null;
    } catch (e) {
      print('BestScore load failed: $e');
      return null;
    }
  }

  Future<void> setBestScore(int score) async {
    try {
      if (score <= 0) return; // 0 이하의 점수는 저장하지 않음
      
      final prefs = ref.watch(sharedPreferencesProvider);
      
      // 현재 최고 점수보다 좋을 때만 업데이트
      final currentBest = state;
      if (currentBest == null || score < currentBest) {
        await prefs.setInt(_key, score);
        state = score;
        print('🏆 New best score: ${score}ms');
      }
    } catch (e) {
      print('BestScore save failed: $e');
    }
  }
}

// 🎮 게임 횟수 관리
@riverpod
class GameCount extends _$GameCount {
  static const String _key = 'game_count';

  @override
  int build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getInt(_key) ?? 0;
  }

  Future<void> incrementCount() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final newCount = state + 1;
    await prefs.setInt(_key, newCount);
    state = newCount;
  }

  Future<void> resetCount() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setInt(_key, 0);
    state = 0;
  }
}

// 📊 평균 점수 관리
@riverpod
class AverageScore extends _$AverageScore {
  static const String _key = 'total_score';
  static const String _countKey = 'total_games';

  @override
  double build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final totalScore = prefs.getInt(_key) ?? 0;
    final totalGames = prefs.getInt(_countKey) ?? 0;
    
    if (totalGames == 0) return 0.0;
    return totalScore / totalGames;
  }

  Future<void> addScore(int score) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final currentTotal = prefs.getInt(_key) ?? 0;
    final currentCount = prefs.getInt(_countKey) ?? 0;
    
    await prefs.setInt(_key, currentTotal + score);
    await prefs.setInt(_countKey, currentCount + 1);
    
    // 새로운 평균 계산
    state = (currentTotal + score) / (currentCount + 1);
  }

  Future<void> reset() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setInt(_key, 0);
    await prefs.setInt(_countKey, 0);
    state = 0.0;
  }
}

// 🏆 상위 10개 기록 관리
@riverpod
class TopScores extends _$TopScores {
  static const String _key = 'top_scores';

  @override
  List<int> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final scores = prefs.getStringList(_key) ?? [];
    return scores.map((s) => int.parse(s)).toList()..sort();
  }

  Future<void> addScore(int score) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final currentScores = List<int>.from(state);
    
    currentScores.add(score);
    currentScores.sort();
    
    // 상위 10개만 유지
    if (currentScores.length > 10) {
      currentScores.removeRange(10, currentScores.length);
    }
    
    final stringScores = currentScores.map((s) => s.toString()).toList();
    await prefs.setStringList(_key, stringScores);
    state = currentScores;
  }

  Future<void> reset() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setStringList(_key, []);
    state = [];
  }
}

// ⚙️ 난이도 설정
@riverpod
class GameDifficulty extends _$GameDifficulty {
  static const String _key = 'game_difficulty';

  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_key) ?? 'normal';
  }

  Future<void> setDifficulty(String difficulty) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setString(_key, difficulty);
    state = difficulty;
  }

  // 난이도별 대기시간 범위 반환
  (int min, int max) getDifficultyRange() {
    return switch (state) {
      'easy' => (1, 3),      // 1-3초
      'normal' => (2, 5),    // 2-5초
      'hard' => (3, 7),      // 3-7초
      _ => (2, 5),
    };
  }
}

// 🔊 사운드 설정
@riverpod
class SoundEnabled extends _$SoundEnabled {
  static const String _key = 'sound_enabled';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? true;
  }

  Future<void> toggle() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setBool(_key, !state);
    state = !state;
  }
}

// 📳 진동 설정
@riverpod
class VibrationEnabled extends _$VibrationEnabled {
  static const String _key = 'vibration_enabled';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? true;
  }

  Future<void> toggle() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setBool(_key, !state);
    state = !state;
  }
}

// 🎨 테마 설정
@riverpod
class AppTheme extends _$AppTheme {
  static const String _key = 'app_theme';

  @override
  String build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_key) ?? 'default';
  }

  Future<void> setTheme(String theme) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setString(_key, theme);
    state = theme;
  }
}

// 🏅 업적 관리
@riverpod
class Achievements extends _$Achievements {
  static const String _key = 'achievements';

  @override
  List<String> build() {
    try {
      final prefs = ref.watch(sharedPreferencesProvider);
      final saved = prefs.getStringList(_key);
      return saved ?? <String>[];
    } catch (e) {
      print('Achievement load failed: $e');
      return <String>[];
    }
  }

  Future<void> unlockAchievement(String achievement) async {
    try {
      if (achievement.isEmpty) return;
      
      final currentAchievements = List<String>.from(state);
      if (!currentAchievements.contains(achievement)) {
        final prefs = ref.watch(sharedPreferencesProvider);
        currentAchievements.add(achievement);
        await prefs.setStringList(_key, currentAchievements);
        state = currentAchievements;
        print('🏅 Achievement unlocked: $achievement');
      }
    } catch (e) {
      print('Achievement unlock failed: $e');
    }
  }

  Future<void> reset() async {
    try {
      final prefs = ref.watch(sharedPreferencesProvider);
      await prefs.setStringList(_key, []);
      state = <String>[];
    } catch (e) {
      print('Achievement reset failed: $e');
    }
  }
}
