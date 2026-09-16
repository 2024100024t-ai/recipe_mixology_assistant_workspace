class CocktailException implements Exception {
  final String message;
  final Object? cause;

  const CocktailException(this.message, [this.cause]);

  @override
  String toString() => cause == null
      ? 'CocktailException: $message'
      : 'CocktailException: $message ($cause)';
}
