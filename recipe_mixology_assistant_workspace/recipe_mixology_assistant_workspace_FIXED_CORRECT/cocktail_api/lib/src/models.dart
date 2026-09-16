class CocktailIngredient {
  final String name;
  final String measure;

  const CocktailIngredient({required this.name, required this.measure});
}

class Cocktail {
  final String id;
  final String name;
  final String? category;
  final String? alcoholic;
  final String? glass;
  final String? instructions;
  final String? thumbnail;
  final List<CocktailIngredient> ingredients;

  const Cocktail({
    required this.id,
    required this.name,
    this.category,
    this.alcoholic,
    this.glass,
    this.instructions,
    this.thumbnail,
    required this.ingredients,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    final id = _requiredString(json, 'idDrink');
    final name = _requiredString(json, 'strDrink');
    final instructions = _optionalString(json['strInstructions']);

    if (instructions == null) {
      throw const FormatException(
        'Invalid cocktail data: strInstructions is required.',
      );
    }

    final ingredients = <CocktailIngredient>[];
    for (var i = 1; i <= 15; i++) {
      final rawName = _optionalString(json['strIngredient$i']);
      if (rawName == null) continue;

      ingredients.add(
        CocktailIngredient(
          name: rawName,
          measure: _optionalString(json['strMeasure$i']) ?? '',
        ),
      );
    }

    return Cocktail(
      id: id,
      name: name,
      category: _optionalString(json['strCategory']),
      alcoholic: _optionalString(json['strAlcoholic']),
      glass: _optionalString(json['strGlass']),
      instructions: instructions,
      thumbnail: _optionalString(json['strDrinkThumb']),
      ingredients: List.unmodifiable(ingredients),
    );
  }

  static String _requiredString(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String || value.trim().isEmpty) {
      throw FormatException('Invalid cocktail data: $key is required.');
    }
    return value.trim();
  }

  static String? _optionalString(Object? value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
