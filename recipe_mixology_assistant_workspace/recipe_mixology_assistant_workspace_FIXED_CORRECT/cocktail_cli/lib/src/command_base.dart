import 'package:cocktail_api/cocktail_api.dart';

abstract class CliCommand {
  CliCommand(this.name, this.description);

  final String name;
  final String description;

  Future<void> execute(CocktailApiClient client, List<String> arguments);
}
