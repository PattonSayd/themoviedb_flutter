import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../api_client/account_api_client.dart';
import '../../api_client/auth_api_client.dart';
import '../../data_providers/session_data_provider.dart';
import 'auth_event.dart';
import 'auth_state.dart';

// enum AuthStatus { authorized, notAuthorized, inProgress }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionProvider = SessionDataProvider();

  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckAuthEvent) {
        await _onCheckAuthEvent(event, emit);
      } else if (event is LoginAuthEvent) {
        await onLoginAuthEvent(event, emit);
      } else if (event is LogoutAuthEvent) {
        await onLogoutAuthEvent(event, emit);
      }
    }, transformer: sequential());

    add(CheckAuthEvent());
  }

  Future<void> _onCheckAuthEvent(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    final sessionId = await _sessionProvider.getSessionId();
    final newState =
        sessionId != null ? AuthorizedAuthState() : NotAuthorizedAuthState();
    emit(newState);
  }

  Future<void> onLoginAuthEvent(
    LoginAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final sessionId = await _authApiClient.auth(
        username: event.login,
        password: event.password,
      );
      final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionProvider.setSessionId(sessionId);
      await _sessionProvider.setAccountId(accountId);
      emit(AuthorizedAuthState());
    } catch (e) {
      emit(FailureAuthState(error: e));
    }
  }

  Future<void> onLogoutAuthEvent(
    LogoutAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _sessionProvider.unSetSessionId();
      await _sessionProvider.unSetAccountId();
    } catch (e) {
      emit(FailureAuthState(error: e));
    }
  }
}
