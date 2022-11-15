import 'dart:convert';
import 'dart:io';

import 'package:the_movie/domain/api_client/api_client_exceptions.dart';

import '../../app/configuration/configuration.dart';

class NetworkClient {
  final _client = HttpClient();

  // "https://api.themoviedb.org/3/movie/popular?api_key=e1be18520018bd22bb1555ed4212a6de&page=1&language=ru_RU"

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${Configuration.host}$path');

    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? params,
  ]) async {
    final url = _makeUri(path, params);

    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = await (response.jsonDecode());
      _validateException(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> parameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? apiKey,
  ]) async {
    try {
      final url = _makeUri(path, apiKey);

      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(parameters));
      final response = await request.close();
      final dynamic json = await (response.jsonDecode());
      _validateException(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.auth);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateException(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final code = json['status_code'] is int ? json['status_code'] : 0;
      code == 30
          ? throw ApiClientException(ApiClientExceptionType.auth)
          : code == 3
              ? throw ApiClientException(ApiClientExceptionType.sessionExpired)
              : throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => json.decode(v));
  }
}
