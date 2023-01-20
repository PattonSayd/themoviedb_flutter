import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:the_movie/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:the_movie/domain/blocs/auth_bloc/auth_event.dart';
import 'package:the_movie/domain/blocs/auth_bloc/auth_state.dart';

enum LoaderState { unknown, authorized, notAuthorized }

class LoaderCubit extends Cubit<LoaderState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderCubit(LoaderState initialState, this.authBloc) : super(initialState) {
    authBloc.add(CheckAuthEvent());
    onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(onState);
  }

  void onState(AuthState state) {
    if (state is AuthorizedAuthState) {
      emit(LoaderState.authorized);
    } else if (state is NotAuthorizedAuthState) {
      emit(LoaderState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}

// class LoaderViewModel {
//   BuildContext context;
//   final _authService = AuthServices();

//   LoaderViewModel(this.context) {
//     initial();
//   }

//   Future<void> initial() async {
//     await checkAuth();
//   }

//   Future<void> checkAuth() async {
//     await _authService.isAuth().then((isAuth) {
//       final screen = isAuth ? AppRouteName.mainScreen : AppRouteName.auth;
//       Navigator.of(context).pushReplacementNamed(screen);
//     });
//   }
// }
