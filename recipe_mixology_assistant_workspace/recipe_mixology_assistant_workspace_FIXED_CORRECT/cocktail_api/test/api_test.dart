import 'dart:async';

import 'package:cocktail_api/cocktail_api.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class FakeClient extends http.BaseClient {
  FakeClient(this.handler);

  final Future<http.Response> Function(http.BaseRequest request) handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await handler(request);
    return http.StreamedResponse(
      Stream<List<int>>.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      request: request,
    );
  }
}

void main() {
  group('Model Deserialisation Suite', () {
    test('Successful parsing of cocktail structure', () {
      final mockJson = {
        'idDrink': '11007',
        'strDrink': 'Margarita',
        'strInstructions': 'Shake with ice and strain.',
        'strIngredient1': 'Tequila',
        'strMeasure1': '1 1/2 oz',
        'strIngredient2': 'Lime juice',
        'strMeasure2': '1 oz',
      };

      final item = Cocktail.fromJson(mockJson);

      expect(item.id, equals('11007'));
      expect(item.name, equals('Margarita'));
      expect(item.instructions, equals('Shake with ice and strain.'));
      expect(item.ingredients.length, equals(2));
      expect(item.ingredients.first.name, equals('Tequila'));
      expect(item.ingredients.first.measure, equals('1 1/2 oz'));
    });

    test('Trigger exception on broken mapping keys', () {
      final malformedJson = {'idDrink': '11007'};

      expect(
        () => Cocktail.fromJson(malformedJson),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('API Client Exception Suite', () {
    test('Converts HTTP failure to CocktailException', () async {
      final client = FakeClient(
        (_) async => http.Response('Server error', 500),
      );
      final api = CocktailApiClient(client);

      expect(
        () => api.fetchCocktail('Margarita'),
        throwsA(isA<CocktailException>()),
      );

      api.close();
    });

    test('Returns null for a valid no-result response', () async {
      final client = FakeClient(
        (_) async => http.Response('{"drinks":null}', 200),
      );
      final api = CocktailApiClient(client);

      final result = await api.fetchCocktail('DefinitelyNotACocktail');

      expect(result, isNull);
      api.close();
    });
  });
}
