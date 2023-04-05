import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/auth_repository/auth_repository_bloc.dart';
import '../../../domain/repositories/auth_repository/auth_repository_event.dart';
import '../../../domain/repositories/auth_repository/auth_repository_state.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<LoaderState> {
  final AuthRepositoryBloc authBloc;
  late final StreamSubscription<AuthRepositoryState> authBlocSubscription;

  LoaderCubit(LoaderState initialState, this.authBloc) : super(initialState) {
    authBloc.add(AuthCheckRepositoryEvent());
    authBlocSubscription = authBloc.stream.listen(onState);
  }

  void onState(AuthRepositoryState state) {
    if (state is AuthorizedRepositoryState) {
      emit(LoaderAuthorizedState());
    } else if (state is UnauthorizedRepositoryState) {
      emit(LoaderNotAuthorizedState());
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
