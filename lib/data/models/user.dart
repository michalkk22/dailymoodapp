// an user is either  a teacher or a student
// an user has a name, role, email
import 'package:equatable/equatable.dart';

enum UserRole { teacher, student }

class User extends Equatable {
  final String userId;
  final String? name;
  final UserRole? role;

  const User({required this.userId, this.name, this.role});

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'name': name,
    'role': role == UserRole.teacher ? 'teacher' : 'student',
  };

  factory User.fromMap(Map<String, dynamic> map, data) => User(
    userId: map['userId'] as String,
    name: map['name'] as String,
    role: (data['role'] == 'teacher') ? UserRole.teacher : UserRole.student,
  );

  @override
  List<Object?> get props => [userId, name, role];
}
