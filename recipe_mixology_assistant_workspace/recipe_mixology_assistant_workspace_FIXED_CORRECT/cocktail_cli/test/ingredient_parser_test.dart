import 'package:cocktail_api/cocktail_api.dart';
import 'package:cocktail_cli/src/ingredient_parser.dart';
import 'package:test/test.dart';

void main() {
  test('parses ounces', () {
    const ingredient = CocktailIngredient(name: 'Tequila', measure: '2 oz');

    final result = parseIngredient(ingredient);

    expect(result.amount, equals(2));
    expect(result.unit, equals('oz'));
    expect(result.display, equals('2 oz Tequila'));
  });

  test('parses mixed fractions', () {
    const ingredient = CocktailIngredient(name: 'Tequila', measure: '1 1/2 oz');

    final result = parseIngredient(ingredient);

    expect(result.amount, closeTo(1.5, 0.0001));
    expect(result.unit, equals('oz'));
  });

  test('parses simple fractions', () {
    const ingredient = CocktailIngredient(name: 'Syrup', measure: '1/2 oz');

    final result = parseIngredient(ingredient);

    expect(result.amount, closeTo(0.5, 0.0001));
    expect(result.unit, equals('oz'));
  });

  test('handles missing instructions', () {
    expect(splitInstructions(null), isEmpty);
    expect(splitInstructions(''), isEmpty);
  });

  test('splits instructions into steps', () {
    final result = splitInstructions(
      'Add ice. Shake well. Strain into a glass.',
    );

    expect(result.length, equals(3));
  });
}
