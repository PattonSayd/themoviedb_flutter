abstract class AuthState {}

class AuthorizedAuthState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthorizedAuthState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

class NotAuthorizedAuthState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotAuthorizedAuthState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

class InProgressAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final Object error;

  FailureAuthState({required this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FailureAuthState &&
          runtimeType == other.runtimeType &&
          error == other.error);

  @override
  int get hashCode => error.hashCode;
}
