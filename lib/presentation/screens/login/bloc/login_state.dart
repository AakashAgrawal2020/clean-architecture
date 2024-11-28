part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String message;
  final ApiStatus status;

  const LoginState(
      {this.email = '',
      this.password = '',
      this.message = '',
      this.status = ApiStatus.initial});

  @override
  List<Object> get props => [email, password, status, message];

  LoginState copyWith(
      {String? email, String? password, String? message, ApiStatus? status}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
