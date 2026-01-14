// an user is either  a teacher or a student
// an user has a name, role, email
import 'package:equatable/equatable.dart';

enum UserRole { teacher, student }

class User extends Equatable {
  final String userId;
  final String name;
  final UserRole role;
  final String email;

  const User({
    required this.userId,
    required this.name,
    required this.role,
    required this.email,
  });

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'name': name,
    'role': role == UserRole.teacher ? 'teacher' : 'student',
    'email': email,
  };

  factory User.fromMap(Map<String, dynamic> map, data) => User(
    userId: map['userId'] as String,
    name: map['name'] as String,
    role: (data['role'] == 'teacher') ? UserRole.teacher : UserRole.student,
    email: map['email'] as String,
  );

  @override
  List<Object?> get props => [userId, name, role, email];
}
