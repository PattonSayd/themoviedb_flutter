part of 'loader_cubit.dart';

@immutable
abstract class LoaderState {}

class LoaderInitial extends LoaderState {}

class LoaderAuthorizedState extends LoaderState {}

class LoaderNotAuthorizedState extends LoaderState {}
