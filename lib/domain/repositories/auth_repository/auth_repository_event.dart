abstract class AuthRepositoryEvent {}

class AuthCheckRepositoryEvent extends AuthRepositoryEvent {}

class AuthLogoutRepositoryEvent extends AuthRepositoryEvent {}

class AuthLoginRepositoryEvent extends AuthRepositoryEvent {
  final String login;
  final String password;

  AuthLoginRepositoryEvent({
    required this.login,
    required this.password,
  });
}
