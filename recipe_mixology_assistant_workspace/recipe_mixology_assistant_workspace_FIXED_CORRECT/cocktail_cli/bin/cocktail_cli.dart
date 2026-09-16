import 'dart:io';

import 'package:cocktail_api/cocktail_api.dart';
import 'package:cocktail_cli/src/command_base.dart';
import 'package:cocktail_cli/src/commands.dart';
import 'package:cocktail_cli/src/logging_config.dart';
import 'package:http/http.dart' as http;
import 'package:terminal_colors/terminal_colors.dart';

Future<void> main() async {
  configureSystemTelemetry();

  final httpClient = http.Client();
  final apiClient = CocktailApiClient(httpClient);

  final commandsList = <CliCommand>[QueryCommand(), HelpCommand()];

  print('Welcome to the Recipe Mixology Assistant!'.styleHeader);
  print('Type "help" for commands or "exit" to leave.'.styleSuccess);

  try {
    while (true) {
      stdout.write('\n[mixology] > ');
      final input = stdin.readLineSync();

      if (input == null || input.trim().toLowerCase() == 'exit') {
        print('Exiting platform...'.styleWarning);
        break;
      }

      final trimmed = input.trim();
      if (trimmed.isEmpty) continue;

      final parts = trimmed.split(RegExp(r'\s+'));
      final commandName = parts.first.toLowerCase();
      final args = parts.sublist(1);

      CliCommand? command;
      for (final candidate in commandsList) {
        if (candidate.name == commandName) {
          command = candidate;
          break;
        }
      }

      if (command == null) {
        print(
          'Unknown command. Type "help" to see available commands.'.styleError,
        );
        continue;
      }

      await command.execute(apiClient, args);
    }
  } finally {
    apiClient.close();
    print('System network socket disconnected successfully.'.styleSuccess);
  }
}
