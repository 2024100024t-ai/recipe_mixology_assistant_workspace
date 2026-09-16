import 'package:cocktail_api/cocktail_api.dart';

class ParsedIngredient {
  final double? amount;
  final String unit;
  final String display;

  const ParsedIngredient({
    required this.amount,
    required this.unit,
    required this.display,
  });
}

ParsedIngredient parseIngredient(CocktailIngredient ingredient) {
  final measure = ingredient.measure.trim();

  if (measure.isEmpty) {
    return ParsedIngredient(amount: null, unit: '', display: ingredient.name);
  }

  final match = RegExp(
    r'^(\d+\s+\d+/\d+|\d+/\d+|\d+(?:\.\d+)?)\s*([A-Za-z]+)?',
  ).firstMatch(measure);

  if (match == null) {
    return ParsedIngredient(
      amount: null,
      unit: '',
      display: '${ingredient.measure} ${ingredient.name}'.trim(),
    );
  }

  final amountText = match.group(1)!;
  final unit = match.group(2) ?? '';

  return ParsedIngredient(
    amount: _parseAmount(amountText),
    unit: unit,
    display: '${ingredient.measure} ${ingredient.name}'.trim(),
  );
}

double? _parseAmount(String value) {
  final text = value.trim();

  // Mixed fraction, e.g. "1 1/2"
  final mixedMatch = RegExp(r'^(\d+)\s+(\d+)/(\d+)$').firstMatch(text);

  if (mixedMatch != null) {
    final whole = double.parse(mixedMatch.group(1)!);
    final numerator = double.parse(mixedMatch.group(2)!);
    final denominator = double.parse(mixedMatch.group(3)!);

    if (denominator == 0) {
      return null;
    }

    return whole + numerator / denominator;
  }

  // Simple fraction, e.g. "1/2"
  final fractionMatch = RegExp(r'^(\d+)/(\d+)$').firstMatch(text);

  if (fractionMatch != null) {
    final numerator = double.parse(fractionMatch.group(1)!);
    final denominator = double.parse(fractionMatch.group(2)!);

    if (denominator == 0) {
      return null;
    }

    return numerator / denominator;
  }

  // Decimal or whole number
  return double.tryParse(text);
}

List<String> splitInstructions(String? instructions) {
  if (instructions == null || instructions.trim().isEmpty) {
    return const [];
  }

  return instructions
      .split(RegExp(r'(?<=[.!?])\s+'))
      .map((step) => step.trim())
      .where((step) => step.isNotEmpty)
      .toList();
}
