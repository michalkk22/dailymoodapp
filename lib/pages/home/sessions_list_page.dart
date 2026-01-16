import 'package:class_pulse/bloc/auth/auth_bloc.dart';
import 'package:class_pulse/data/models/session.dart';
import 'package:class_pulse/pages/home/session_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionsListPage extends StatelessWidget {
  const SessionsListPage({super.key, required this.sessions});
  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().user;
    final name = user?.name ?? 'there';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi $name,',
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2D5A88),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthEventLogOut());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                'Here are your sessions.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 18),

              if (sessions.isEmpty)
                const _EmptyStateCard()
              else
                ...sessions.map((s) => _SessionCard(session: s)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});
  final Session session;

  @override
  Widget build(BuildContext context) {
    final time = _formatTime(session.dateTime);

    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SessionDetailPage(session: session),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.subject,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2D3D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$time · ${session.teacher}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _StatusPill(isSubmitted: session.isSubmitted),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.isSubmitted});
  final bool isSubmitted;

  @override
  Widget build(BuildContext context) {
    final bg = isSubmitted ? const Color(0xFFE7F6EE) : const Color(0xFFEFF3F8);
    final fg = isSubmitted ? const Color(0xFF2E7D32) : const Color(0xFF637085);
    final label = isSubmitted ? 'Submitted' : 'Not submitted';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 13),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.event_busy_rounded,
              color: Color(0xFF2D5A88),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'No sessions yet.\nOnce your teacher creates sessions, they will appear here.',
              style: TextStyle(color: Colors.grey.shade700, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTime(DateTime dt) {
  final h = dt.hour;
  final m = dt.minute.toString().padLeft(2, '0');
  final suffix = h >= 12 ? 'pm' : 'am';
  final h12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
  return '$h12:$m$suffix';
}
