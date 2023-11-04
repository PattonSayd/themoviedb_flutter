import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../api_client/account_api_client.dart';
import '../../api_client/auth_api_client.dart';
import '../../data_providers/session_data_provider.dart';
import 'auth_repository_event.dart';
import 'auth_repository_state.dart';

class AuthRepositoryBloc
    extends Bloc<AuthRepositoryEvent, AuthRepositoryState> {
  final _authApiClient = AuthApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionProvider = SessionDataProvider();

  AuthRepositoryBloc(AuthRepositoryState initialState) : super(initialState) {
    on<AuthRepositoryEvent>((event, emit) async {
      if (event is AuthCheckRepositoryEvent) {
        await _onCheckAuthEvent(event, emit);
      } else if (event is AuthLoginRepositoryEvent) {
        await onLoginAuthEvent(event, emit);
      } else if (event is AuthLogoutRepositoryEvent) {
        await onLogoutAuthEvent(event, emit);
      }
    }, transformer: sequential());
  }

  Future<void> _onCheckAuthEvent(
    AuthCheckRepositoryEvent event,
    Emitter<AuthRepositoryState> emit,
  ) async {
    final sessionId = await _sessionProvider.getSessionId();
    final newState = sessionId != null
        ? AuthorizedRepositoryState()
        : UnauthorizedRepositoryState();
    emit(newState);
  }

  Future<void> onLoginAuthEvent(
    AuthLoginRepositoryEvent event,
    Emitter<AuthRepositoryState> emit,
  ) async {
    try {
      final sessionId = await _authApiClient.auth(
          username: event.login, password: event.password);
      final accountId = await _accountApiClient.getAccountInfo(sessionId);
      await _sessionProvider.setSessionId(sessionId);
      await _sessionProvider.setAccountId(accountId);
      emit(AuthorizedRepositoryState());
    } catch (e) {
      emit(AuthFailureRepositoryState(error: e));
    }
  }

  Future<void> onLogoutAuthEvent(
    AuthLogoutRepositoryEvent event,
    Emitter<AuthRepositoryState> emit,
  ) async {
    try {
      await _sessionProvider.unSetSessionId();
      await _sessionProvider.unSetAccountId();
    } catch (e) {
      emit(AuthFailureRepositoryState(error: e));
    }
  }
}
