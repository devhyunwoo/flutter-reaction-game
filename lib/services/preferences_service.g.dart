// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'9ce5d3a1d8e34e1852c77b7a602fe3158dd8f0ca';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
String _$bestScoreHash() => r'5b435f04c0f3c9e7dd281eebe7a97e7ada824181';

/// See also [BestScore].
@ProviderFor(BestScore)
final bestScoreProvider = AutoDisposeNotifierProvider<BestScore, int?>.internal(
  BestScore.new,
  name: r'bestScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bestScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BestScore = AutoDisposeNotifier<int?>;
String _$gameCountHash() => r'969a126e3ae8a7380a0b85311d1f8de2fdda2b2a';

/// See also [GameCount].
@ProviderFor(GameCount)
final gameCountProvider = AutoDisposeNotifierProvider<GameCount, int>.internal(
  GameCount.new,
  name: r'gameCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gameCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameCount = AutoDisposeNotifier<int>;
String _$averageScoreHash() => r'bf16c6bd214e1f5cbfb7b2f662414f065336472b';

/// See also [AverageScore].
@ProviderFor(AverageScore)
final averageScoreProvider =
    AutoDisposeNotifierProvider<AverageScore, double>.internal(
      AverageScore.new,
      name: r'averageScoreProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$averageScoreHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AverageScore = AutoDisposeNotifier<double>;
String _$topScoresHash() => r'522cb562ef803dc30f7ed6db932296060423476b';

/// See also [TopScores].
@ProviderFor(TopScores)
final topScoresProvider =
    AutoDisposeNotifierProvider<TopScores, List<int>>.internal(
      TopScores.new,
      name: r'topScoresProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$topScoresHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TopScores = AutoDisposeNotifier<List<int>>;
String _$gameDifficultyHash() => r'98efe164861f3ca66faff61161c88ab2edfe82fa';

/// See also [GameDifficulty].
@ProviderFor(GameDifficulty)
final gameDifficultyProvider =
    AutoDisposeNotifierProvider<GameDifficulty, String>.internal(
      GameDifficulty.new,
      name: r'gameDifficultyProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gameDifficultyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GameDifficulty = AutoDisposeNotifier<String>;
String _$soundEnabledHash() => r'05b9c0bb6de9ba9a1ddd5e8b58054f52364480c4';

/// See also [SoundEnabled].
@ProviderFor(SoundEnabled)
final soundEnabledProvider =
    AutoDisposeNotifierProvider<SoundEnabled, bool>.internal(
      SoundEnabled.new,
      name: r'soundEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$soundEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SoundEnabled = AutoDisposeNotifier<bool>;
String _$vibrationEnabledHash() => r'5f256f461344ed61a8dfccce681c7d5e1771fa86';

/// See also [VibrationEnabled].
@ProviderFor(VibrationEnabled)
final vibrationEnabledProvider =
    AutoDisposeNotifierProvider<VibrationEnabled, bool>.internal(
      VibrationEnabled.new,
      name: r'vibrationEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vibrationEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VibrationEnabled = AutoDisposeNotifier<bool>;
String _$appThemeHash() => r'ab60a270f15ddbecd9e98f9ea43d6591092c61a8';

/// See also [AppTheme].
@ProviderFor(AppTheme)
final appThemeProvider = AutoDisposeNotifierProvider<AppTheme, String>.internal(
  AppTheme.new,
  name: r'appThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppTheme = AutoDisposeNotifier<String>;
String _$achievementsHash() => r'6eb99d42eda212edc642278eb963ef7eaa7afcd4';

/// See also [Achievements].
@ProviderFor(Achievements)
final achievementsProvider =
    AutoDisposeNotifierProvider<Achievements, List<String>>.internal(
      Achievements.new,
      name: r'achievementsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$achievementsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Achievements = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
