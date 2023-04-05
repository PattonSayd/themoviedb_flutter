part of 'auth_cubit_cubit.dart';

@immutable
abstract class AuthCubitState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthCubitState;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitSuccessState extends AuthCubitState {}

class AuthCubitFailureState extends AuthCubitState {
  final String errorMessage;
  AuthCubitFailureState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthCubitFailureState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
