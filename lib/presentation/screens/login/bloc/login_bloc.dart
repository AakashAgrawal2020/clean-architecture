import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/services/session/session_manager.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/domain/repositories/auth/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<UserLogin>(_userLogin);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _userLogin(UserLogin event, Emitter<LoginState> emit) async {
    Map<String, dynamic> data = {
      "email": state.email,
      "password": state.password
    };
    emit(state.copyWith(status: ApiStatus.loading));

    await loginRepository.userLogin(data).then((value) async {
      if (value.token.isNotEmpty) {
        SessionManager()
            .setSessionToken(token: value.token)
            .whenComplete(() async {
          await SessionManager().getSessionToken();
        });
        emit(state.copyWith(
            status: ApiStatus.completed, message: Strings.loginSuccessful));
      } else if (value.error.isNotEmpty) {
        emit(state.copyWith(status: ApiStatus.error, message: value.error));
      } else {
        emit(state.copyWith(
            status: ApiStatus.error, message: Strings.loginFailed));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: ApiStatus.error, message: Strings.loginFailed));
    });
  }
}
