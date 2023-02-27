abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthorizedState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

class UnauthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnauthorizedState && runtimeType == other.runtimeType);

  @override
  int get hashCode => 0;
}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState({required this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthFailureState &&
          runtimeType == other.runtimeType &&
          error == other.error);

  @override
  int get hashCode => error.hashCode;
}
