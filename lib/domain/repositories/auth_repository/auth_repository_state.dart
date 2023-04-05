abstract class AuthRepositoryState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthRepositoryState;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class AuthRepositoryInitial extends AuthRepositoryState {}

class AuthorizedRepositoryState extends AuthRepositoryState {}

class UnauthorizedRepositoryState extends AuthRepositoryState {}

class AuthFailureRepositoryState extends AuthRepositoryState {
  final Object error;

  AuthFailureRepositoryState({required this.error});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthFailureRepositoryState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
