import '../../configuration/configuration.dart';
import 'network_client.dart';

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';

      case MediaType.tv:
        return 'sd';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    int parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _networkClient.get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );

    return result;
  }

  Future<String> markAsFavorite({
    required int accountId,
    required String sessionId,
    required int mediaId,
    required MediaType mediaType,
    required bool isFavorite,
  }) async {
    String parser(dynamic json) {
      return '';
    }

    final parameters = <String, dynamic>{
      'media_id': mediaId,
      'media_type': mediaType.asString(),
      'favorite': isFavorite,
    };
    final result = _networkClient.post(
      '/account/$accountId/favorite',
      parameters,
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
