part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStart extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String userId;
  final String password;

  LoggedIn({required this.userId, required this.password});

  @override
  String toString() => 'LoggedIn { user_id: $userId, password: $password }';
}

class Logout extends AuthEvent {}
