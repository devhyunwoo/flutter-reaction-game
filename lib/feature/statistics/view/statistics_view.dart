import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reaction_check_app/services/preferences_service.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsView extends ConsumerWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bestScore = ref.watch(bestScoreProvider);
    final gameCount = ref.watch(gameCountProvider);
    final averageScore = ref.watch(averageScoreProvider);
    final topScores = ref.watch(topScoresProvider);
    final achievements = ref.watch(achievementsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.bar_chart, color: Colors.white),
            SizedBox(width: 8),
            Text(
              '📊 통계',
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
          child: gameCount == 0 
            ? _buildEmptyState() 
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                // 📊 주요 통계 요약
                _buildStatsSummary(bestScore, gameCount, averageScore),
                
                const SizedBox(height: 16),
                
                // 📈 성과 차트
                if (topScores.length >= 3) ...[
                  _buildPerformanceChart(topScores),
                  const SizedBox(height: 16),
                ],
                
                // 🏆 상위 기록
                _buildTopScores(topScores),
                
                const SizedBox(height: 16),
                
                // 🏅 업적
                _buildAchievements(achievements),
                
                const SizedBox(height: 32),
                ],
              ),
          ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.purple.shade300],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bar_chart,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '아직 게임 기록이 없어요!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '첫 게임을 플레이하면\n여기에 통계가 나타납니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSummary(int? bestScore, int gameCount, double averageScore) {
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
            const Text(
              '📊 주요 통계',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // 🏆 최고 기록
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.emoji_events,
                    iconColor: Colors.amber.shade600,
                    title: '최고 기록',
                    value: bestScore != null ? '${bestScore}ms' : '기록 없음',
                    backgroundColor: Colors.amber.shade50,
                  ),
                ),
                const SizedBox(width: 12),
                
                // 📈 평균 점수
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.trending_up,
                    iconColor: Colors.green.shade600,
                    title: '평균 점수',
                    value: gameCount > 0 ? '${averageScore.toStringAsFixed(1)}ms' : '0ms',
                    backgroundColor: Colors.green.shade50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // 🎮 게임 횟수
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.sports_esports,
                    iconColor: Colors.blue.shade600,
                    title: '총 게임',
                    value: '${gameCount}회',
                    backgroundColor: Colors.blue.shade50,
                  ),
                ),
                const SizedBox(width: 12),
                
                // 📊 개선도
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.trending_up,
                    iconColor: Colors.purple.shade600,
                    title: '개선도',
                    value: _calculateImprovement(bestScore, averageScore),
                    backgroundColor: Colors.purple.shade50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }

  String _calculateImprovement(int? bestScore, double averageScore) {
    if (bestScore == null || averageScore == 0) return '-';
    final improvement = ((averageScore - bestScore) / averageScore * 100).abs();
    return '${improvement.toStringAsFixed(1)}%';
  }

  Widget _buildPerformanceChart(List<int> topScores) {
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
            const Text(
              '📈 성과 차트',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: topScores.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value.toDouble());
                      }).toList(),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.purple.shade400],
                      ),
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade100.withOpacity(0.5),
                            Colors.purple.shade100.withOpacity(0.5),
                          ],
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.blue.shade600,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}ms',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt() + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 50,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.shade200,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '* 상위 ${topScores.length}개 기록의 변화',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopScores(List<int> topScores) {
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
            const Text(
              '🏆 상위 기록',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            topScores.isEmpty
                ? Text(
                    '아직 기록이 없습니다',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  )
                : Column(
                    children: topScores.asMap().entries.map((entry) {
                      final index = entry.key;
                      final score = entry.value;
                      return _buildScoreItem(index + 1, score, index < 3);
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(int rank, int score, bool isTopThree) {
    Color getRankColor() {
      switch (rank) {
        case 1:
          return Colors.amber.shade600;
        case 2:
          return Colors.grey.shade600;
        case 3:
          return Colors.brown.shade600;
        default:
          return Colors.grey.shade500;
      }
    }

    IconData getRankIcon() {
      switch (rank) {
        case 1:
          return Icons.looks_one;
        case 2:
          return Icons.looks_two;
        case 3:
          return Icons.looks_3;
        default:
          return Icons.circle;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isTopThree ? getRankColor().withOpacity(0.1) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTopThree ? getRankColor().withOpacity(0.3) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: getRankColor(),
              shape: BoxShape.circle,
            ),
            child: Icon(
              getRankIcon(),
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '${rank}위',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: getRankColor(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getRankColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${score}ms',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: getRankColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(List<String> achievements) {
    final allAchievements = [
      {'id': 'lightning_fast', 'title': '⚡ 번개같이!', 'description': '200ms 이하 달성', 'icon': Icons.flash_on},
      {'id': 'flash_master', 'title': '🔥 플래시 마스터', 'description': '150ms 이하 달성', 'icon': Icons.whatshot},
      {'id': 'superhuman', 'title': '🦸 초인간', 'description': '100ms 이하 달성', 'icon': Icons.bolt},
      {'id': 'dedicated_player', 'title': '🎮 열정적인 플레이어', 'description': '10게임 완료', 'icon': Icons.sports_esports},
      {'id': 'reaction_veteran', 'title': '🏅 반응속도 베테랑', 'description': '50게임 완료', 'icon': Icons.military_tech},
      {'id': 'thousand_touches', 'title': '✋ 천 번의 터치', 'description': '100게임 완료', 'icon': Icons.touch_app},
      {'id': 'new_record', 'title': '📈 신기록!', 'description': '개인 최고 기록 갱신', 'icon': Icons.trending_up},
    ];

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🏅 업적',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade400, Colors.blue.shade400],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${achievements.length}/${allAchievements.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: (allAchievements.length / 2).ceil() * 120.0, // 고정 높이 설정
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: allAchievements.length,
                itemBuilder: (context, index) {
                  if (index >= allAchievements.length) return const SizedBox.shrink();
                  
                  final achievement = allAchievements[index];
                  final achievementId = achievement['id'] as String? ?? '';
                  final isUnlocked = achievements.contains(achievementId);
                  return _buildAchievementCard(achievement, isUnlocked);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement, bool isUnlocked) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked ? Colors.amber.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? Colors.amber.shade200 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            achievement['icon'] as IconData,
            size: 32,
            color: isUnlocked ? Colors.amber.shade600 : Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            achievement['title'] as String,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isUnlocked ? Colors.amber.shade800 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            achievement['description'] as String,
            style: TextStyle(
              fontSize: 10,
              color: isUnlocked ? Colors.amber.shade600 : Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 