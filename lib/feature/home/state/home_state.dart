import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum GameStatus {
  initial,     // 🎯 초기 상태 (시작 화면)
  waiting,     // 대기 중
  ready,       // 터치 신호 (초록색)
  finished,    // 결과 표시
  preClicked;  // 미리 클릭
  
  // 🎯 텍스트와 색상을 enum에서 한번에 관리!
  String getText(int? reactionTime) => switch (this) {
    GameStatus.initial => "게임을 시작하세요!",        // 🎯 새로 추가
    GameStatus.waiting => "대기대기 김대기!",
    GameStatus.ready => "화면을 눌러주세요.",
    GameStatus.finished => "반응속도: ${reactionTime}ms",
    GameStatus.preClicked => "미리 눌렀네요? 다시 시도해주세요.",
  };
  
  Color get backgroundColor => switch (this) {
    GameStatus.initial => Colors.white,               // 🎯 새로 추가
    GameStatus.waiting => Colors.white,
    GameStatus.ready => Colors.green,
    GameStatus.finished => Colors.blueGrey,
    GameStatus.preClicked => Colors.yellow,
  };
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(GameStatus.initial) GameStatus status,    // 🎯 initial로 시작
    @Default(0) int reactionTime,                      
    @Default(0) int startTimeStamp,                    
  }) = _HomeState;
}
