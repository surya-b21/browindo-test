part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStart extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String user_id;
  final String password;

  LoggedIn({required this.user_id, required this.password});

  @override
  String toString() => 'LoggedIn { user_id: $user_id, password: $password }';
}

class Logout extends AuthEvent {}
