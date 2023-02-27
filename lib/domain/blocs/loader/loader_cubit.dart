import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_event.dart';
import '../auth_bloc/auth_state.dart';

part 'loader_state.dart';

class LoaderCubit extends Cubit<LoaderState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderCubit(LoaderState initialState, this.authBloc) : super(initialState) {
    authBloc.add(AuthCheckEvent());
    authBlocSubscription = authBloc.stream.listen(onState);
  }

  void onState(AuthState state) {
    if (state is AuthorizedState) {
      emit(LoaderAuthorizedState());
    } else if (state is UnauthorizedState) {
      emit(LoaderNotAuthorizedState());
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
