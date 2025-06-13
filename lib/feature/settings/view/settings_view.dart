import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reaction_check_app/services/preferences_service.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(gameDifficultyProvider);
    final soundEnabled = ref.watch(soundEnabledProvider);
    final vibrationEnabled = ref.watch(vibrationEnabledProvider);
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.settings, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '⚙️ 설정',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade600,
                Colors.indigo.shade600,
                Colors.blue.shade600,
              ],
            ),
          ),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
            // 🎲 게임 설정
            _buildSectionCard(
              title: '🎮 게임 설정',
              children: [
                _buildDifficultySelector(ref, difficulty),
                const SizedBox(height: 16),
                _buildResetButton(ref),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 🔊 오디오 & 햅틱 설정
            _buildSectionCard(
              title: '🔊 오디오 & 햅틱',
              children: [
                _buildSwitchTile(
                  title: '사운드 효과',
                  subtitle: '성공/실패 사운드 재생',
                  value: soundEnabled,
                  onChanged: (value) {
                    ref.read(soundEnabledProvider.notifier).toggle();
                  },
                  icon: Icons.volume_up,
                ),
                _buildSwitchTile(
                  title: '진동',
                  subtitle: '터치 시 진동 피드백',
                  value: vibrationEnabled,
                  onChanged: (value) {
                    ref.read(vibrationEnabledProvider.notifier).toggle();
                  },
                  icon: Icons.vibration,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 🎨 외관 설정
            _buildSectionCard(
              title: '🎨 외관',
              children: [
                _buildThemeSelector(ref, theme),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 📊 데이터 관리
            _buildSectionCard(
              title: '📊 데이터 관리',
              children: [
                _buildDangerButton(
                  title: '모든 기록 초기화',
                  subtitle: '최고 기록, 통계, 업적을 모두 삭제합니다',
                  onPressed: () => _showResetDialog(context, ref),
                  icon: Icons.delete_forever,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // 📱 앱 정보
            _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultySelector(WidgetRef ref, String currentDifficulty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '난이도 설정',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildDifficultyChip(
              ref: ref,
              label: '쉬움',
              value: 'easy',
              description: '1-3초',
              isSelected: currentDifficulty == 'easy',
              color: Colors.green,
            ),
            const SizedBox(width: 8),
            _buildDifficultyChip(
              ref: ref,
              label: '보통',
              value: 'normal',
              description: '2-5초',
              isSelected: currentDifficulty == 'normal',
              color: Colors.blue,
            ),
            const SizedBox(width: 8),
            _buildDifficultyChip(
              ref: ref,
              label: '어려움',
              value: 'hard',
              description: '3-7초',
              isSelected: currentDifficulty == 'hard',
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDifficultyChip({
    required WidgetRef ref,
    required String label,
    required String value,
    required String description,
    required bool isSelected,
    required Color color,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(gameDifficultyProvider.notifier).setDifficulty(value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white70 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.blue.shade600,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(WidgetRef ref, String currentTheme) {
    final themes = [
      {'value': 'default', 'label': '기본', 'color': Colors.blue},
      {'value': 'dark', 'label': '다크', 'color': Colors.grey},
      {'value': 'colorful', 'label': '컬러풀', 'color': Colors.purple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '테마 선택',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: themes.map((theme) {
            final isSelected = currentTheme == theme['value'];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    ref.read(appThemeProvider.notifier).setTheme(theme['value'] as String);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? theme['color'] as Color : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? theme['color'] as Color : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      theme['label'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResetButton(WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.refresh, color: Colors.blue.shade600, size: 24),
          const SizedBox(height: 8),
          Text(
            '설정 초기화',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          Text(
            '모든 설정을 기본값으로 되돌립니다',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerButton({
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.red.shade600, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.red.shade600),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.purple.shade400],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.flash_on,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '⚡ 반응속도 테스트 ⚡',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'v1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '당신의 반응속도를 테스트하고\n기록을 개선해보세요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ 데이터 초기화'),
        content: const Text(
          '모든 기록, 통계, 업적이 영구적으로 삭제됩니다.\n정말로 초기화하시겠습니까?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // 모든 데이터 초기화
              ref.read(bestScoreProvider.notifier).setBestScore(0);
              ref.read(gameCountProvider.notifier).resetCount();
              ref.read(averageScoreProvider.notifier).reset();
              ref.read(topScoresProvider.notifier).reset();
              ref.read(achievementsProvider.notifier).reset();
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ 모든 데이터가 초기화되었습니다'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }
} 