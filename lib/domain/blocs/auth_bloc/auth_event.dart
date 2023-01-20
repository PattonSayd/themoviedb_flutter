abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class LogoutAuthEvent extends AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String login;
  final String password;

  LoginAuthEvent({
    required this.login,
    required this.password,
  });
}
