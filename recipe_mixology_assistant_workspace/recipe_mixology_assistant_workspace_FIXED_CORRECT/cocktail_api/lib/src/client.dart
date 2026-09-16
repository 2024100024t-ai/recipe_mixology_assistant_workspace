import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'exceptions.dart';
import 'models.dart';

class CocktailApiClient {
  CocktailApiClient(this._client);

  final http.Client _client;
  final Logger _logger = Logger('CocktailApiClient');

  static const String _authority = 'www.thecocktaildb.com';

  Future<Cocktail?> fetchCocktail(String query) async {
    final name = query.trim();
    if (name.isEmpty) {
      throw const CocktailException('Cocktail name cannot be empty.');
    }

    final uri = Uri.https(_authority, '/api/json/v1/1/search.php', {'s': name});

    _logger.info('Searching for cocktail: $name');

    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        _logger.warning('HTTP ${response.statusCode}');
        throw CocktailException(
          'Remote server rejected the request (HTTP ${response.statusCode}).',
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const CocktailException('Unexpected JSON response structure.');
      }

      final drinks = decoded['drinks'];
      if (drinks == null) return null;
      if (drinks is! List || drinks.isEmpty) {
        throw const CocktailException('Invalid drinks response.');
      }

      final first = drinks.first;
      if (first is! Map<String, dynamic>) {
        throw const CocktailException('Invalid cocktail object.');
      }

      return Cocktail.fromJson(first);
    } on CocktailException {
      rethrow;
    } on http.ClientException catch (e) {
      _logger.severe('Network communication failed.', e);
      throw CocktailException('Network communication failed.', e);
    } on FormatException catch (e) {
      _logger.severe('Response parsing failed.', e);
      throw CocktailException('Could not parse the API response.', e);
    } catch (e) {
      _logger.severe('Unexpected API failure.', e);
      throw CocktailException('Unexpected API failure.', e);
    }
  }

  void close() => _client.close();
}
