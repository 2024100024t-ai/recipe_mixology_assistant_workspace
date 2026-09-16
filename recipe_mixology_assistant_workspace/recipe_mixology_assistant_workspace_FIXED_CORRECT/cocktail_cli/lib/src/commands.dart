import 'package:cocktail_api/cocktail_api.dart';
import 'package:terminal_colors/terminal_colors.dart';

import 'command_base.dart';
import 'ingredient_parser.dart';

class QueryCommand extends CliCommand {
  QueryCommand() : super('query', 'Search for a cocktail by name.');

  @override
  Future<void> execute(CocktailApiClient client, List<String> arguments) async {
    if (arguments.isEmpty) {
      print('Usage: query <cocktail name>'.styleError);
      return;
    }

    final query = arguments.join(' ');

    try {
      final cocktail = await client.fetchCocktail(query);

      if (cocktail == null) {
        print('No cocktail found for "$query".'.styleWarning);
        return;
      }

      final buffer = StringBuffer()
        ..writeln('========== ${cocktail.name} =========='.styleHeader)
        ..writeln('ID: ${cocktail.id}')
        ..writeln('Category: ${cocktail.category ?? 'Not provided'}')
        ..writeln('Alcoholic: ${cocktail.alcoholic ?? 'Not provided'}')
        ..writeln('Glass: ${cocktail.glass ?? 'Not provided'}')
        ..writeln()
        ..writeln('INGREDIENTS'.styleHeader);

      if (cocktail.ingredients.isEmpty) {
        buffer.writeln('  No ingredients listed.');
      } else {
        for (final ingredient in cocktail.ingredients) {
          final parsed = parseIngredient(ingredient);
          buffer
            ..writeln('  • ${parsed.display}')
            ..writeln(
              '    Parsed amount: ${parsed.amount?.toString() ?? 'unknown'} ${parsed.unit}'
                  .trim(),
            );
        }
      }

      buffer
        ..writeln()
        ..writeln('INSTRUCTIONS'.styleHeader);

      final steps = splitInstructions(cocktail.instructions);
      if (steps.isEmpty) {
        buffer.writeln('  No instructions provided.');
      } else {
        for (var i = 0; i < steps.length; i++) {
          buffer.writeln('  ${i + 1}. ${steps[i]}');
        }
      }

      buffer.writeln('==========================================');
      print(buffer.toString());
    } on CocktailException catch (e) {
      print('Operation failed: $e'.styleError);
    }
  }
}

class HelpCommand extends CliCommand {
  HelpCommand() : super('help', 'Display available commands.');

  @override
  Future<void> execute(CocktailApiClient client, List<String> arguments) async {
    final buffer = StringBuffer()
      ..writeln('Available commands:'.styleHeader)
      ..writeln('  query <name>  Search for a cocktail')
      ..writeln('  help          Show available commands')
      ..writeln('  exit          Exit the application');

    print(buffer.toString());
  }
}
