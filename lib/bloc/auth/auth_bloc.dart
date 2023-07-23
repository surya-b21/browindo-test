// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:test_flreelance/services/auth_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _storage = const FlutterSecureStorage();
  final _user = UserServices();

  AuthBloc() : super(AuthInitial()) {
    on<AppStart>((event, emit) async {
      String? token = await _storage.read(key: 'token');

      if (token == null) {
        emit(AuthUnauthenticated());
      } else {
        emit(AuthAuthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      String? message = await _user.login(event.userId, event.password);

      if (message == "Berhasil login") {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<Logout>((event, emit) async {
      emit(AuthLoading());
      await _storage.delete(key: 'token');
      emit(AuthUnauthenticated());
    });
  }
}
