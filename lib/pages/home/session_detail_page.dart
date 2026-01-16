import 'package:flutter/material.dart';
import '../models/session_model.dart';

class SessionDetailPage extends StatelessWidget {
  static const routeName = '/session_detail';

  const SessionDetailPage({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    final moods = ['😄', '🙂', '😐', '😡', '😴'];
    final totalResponses =
        session.moodCounts.fold<int>(0, (sum, v) => sum + v);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F4F8),
        elevation: 0,
        foregroundColor: const Color(0xFF2D5A88),
        title: Text(
          '${session.subject} – ${session.dayLabel}, ${session.timeLabel}',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF2D5A88),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${session.teacher}’s Class',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 16),

              // Frage + Emojis
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How do you feel right now?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2D3D),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: moods.map((m) {
                        return _EmojiBubble(
                          emoji: m,
                          selected: m == '😄',
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Class Mood section
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class Mood',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalResponses responses',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _MoodBarChart(counts: session.moodCounts),
                    const SizedBox(height: 18),
                    const Text(
                      'Mood History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2D3D),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: moods
                          .map(
                            (m) => Text(
                              m,
                              style: const TextStyle(fontSize: 26),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiBubble extends StatelessWidget {
  const _EmojiBubble({required this.emoji, required this.selected});

  final String emoji;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE8F0FE) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: selected ? const Color(0xFF4A90E2) : const Color(0xFFE0E0E0),
          width: selected ? 2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// einfacher "Fake" Balken-Chart ohne zusätzliche Libraries
class _MoodBarChart extends StatelessWidget {
  const _MoodBarChart({required this.counts});
  final List<int> counts;

  @override
  Widget build(BuildContext context) {
    final max = counts.isEmpty ? 1 : counts.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < counts.length; i++)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 28,
                  height: max == 0
                      ? 0
                      : (100.0 * counts[i] / max).clamp(10.0, 100.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ['Mon', 'Wed', 'Thu', 'Fri', 'Sat'][i],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
