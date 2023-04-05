part of 'loader_cubit.dart';

@immutable
abstract class LoaderState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoaderState;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class LoaderInitial extends LoaderState {}

class LoaderAuthorizedState extends LoaderState {}

class LoaderNotAuthorizedState extends LoaderState {}
