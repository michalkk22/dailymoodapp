// a response takes the mood and the time of submission
// it comes from a student

import 'package:equatable/equatable.dart';

class Response extends Equatable {
  final String studentId;
  final String mood;
  final DateTime time;

  const Response({
    required this.studentId,
    required this.mood,
    required this.time,
  });

  Map<String, dynamic> toMap() =>
      {
        'StudentId': studentId,
        'mood': mood,
        'time': time
            .toUtc()
            .millisecondsSinceEpoch,
      };

  factory Response.fromMap(Map<String, dynamic> map) =>
      Response(
        studentId: map['StudentId'] as String,
        mood: map['mood'] as String,
        time: DateTime.fromMillisecondsSinceEpoch(
          (map['time'] as int),
          isUtc: true,
        ).toLocal(),
      );

  @override
  List<Object?> get props => [studentId, mood, time];
}
