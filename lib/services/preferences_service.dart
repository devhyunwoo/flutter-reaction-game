import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_service.g.dart'; // 자동 생성될 파일

// SharedPreferences 인스턴스 제공
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(); // main에서 override 할 거예요
}

// 사용자 이름 관리 클래스
@riverpod
class BestScore extends _$BestScore {
  static const String _key = 'bast_score';

  @override
  int? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getInt(_key); // 앱 시작할 때 저장된 값 로드
  }

  Future<void> setBestScore(int score) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setInt(_key, score);
    state = score; // 상태 업데이트
  }
}
