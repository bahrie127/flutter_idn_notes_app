part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthResponseModel data;

  LoginSuccess({
    required this.data,
  });
}

final class LoginFailed extends LoginState {
  final String message;

  LoginFailed({
    required this.message,
  });
}


