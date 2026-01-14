// a session is created by a teacher (date + subject)
// a student can join a session and submit how they feel
// a session has an id, a subject, a teacher that created it, a date and time, and a list of students who joined
import 'package:equatable/equatable.dart';

class SessionModel extends Equatable {
  final String sessionId;
  final String subject;
  final String teacher; //nom ou id
  final DateTime dateTime;
  final bool isSubmitted;

  const SessionModel({
    required this.sessionId,
    required this.subject,
    required this.teacher,
    required this.dateTime,
    this.isSubmitted = false,
  });

  Map<String, dynamic> toMap() => {
    'sessionId': sessionId,
    'subject': subject,
    'teacher': teacher,
    'dateTime': dateTime.toUtc().millisecondsSinceEpoch,
    'isSubmitted': isSubmitted,
  };

  factory SessionModel.fromMap(Map<String, dynamic> map) => SessionModel(
    sessionId: map['sessionId'] as String,
    subject: map['subject'] as String,
    teacher: map['teacher'] as String,
    dateTime: DateTime.fromMillisecondsSinceEpoch(
      (map['dateTime'] as int),
      isUtc: true,
    ).toLocal(),
    isSubmitted: map['isSubmitted'] as bool,
  );

  @override
  List<Object?> get props => [
    sessionId,
    subject,
    teacher,
    dateTime,
    isSubmitted,
  ];
}
