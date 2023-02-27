import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../api_client/account_api_client.dart';
import '../../api_client/auth_api_client.dart';
import '../../data_providers/session_data_provider.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionProvider = SessionDataProvider();

  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckEvent) {
        await _onCheckAuthEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onLoginAuthEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onLogoutAuthEvent(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _onCheckAuthEvent(
    AuthCheckEvent event,
    Emitter<AuthState> emit,
  ) async {
    final sessionId = await _sessionProvider.getSessionId();
    final newState =
        sessionId != null ? AuthorizedState() : UnauthorizedState();
    emit(newState);
  }

  Future<void> onLoginAuthEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final sessionId = await _authApiClient.auth(
          username: event.login, password: event.password);
      final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionProvider.setSessionId(sessionId);
      await _sessionProvider.setAccountId(accountId);
      emit(AuthorizedState());
    } catch (e) {
      emit(AuthFailureState(error: e));
    }
  }

  Future<void> onLogoutAuthEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _sessionProvider.unSetSessionId();
      await _sessionProvider.unSetAccountId();
    } catch (e) {
      emit(AuthFailureState(error: e));
    }
  }
}
