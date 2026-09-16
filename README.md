[Recipe Mixology Assistant — README.md](https://github.com/user-attachments/files/32274893/Recipe.Mixology.Assistant.README.md)
# Recipe Mixology Assistant

## Description

**Recipe Mixology Assistant** is a Dart-based command-line application designed to help users search for cocktail recipes and view detailed drink information directly from the terminal. The application connects to **TheCocktailDB API** to retrieve cocktail data, processes the response, and presents the recipe in an organized and readable format.

The project demonstrates important Dart programming concepts including API integration, JSON deserialization, object-oriented programming, exception handling, asynchronous programming, command-line interaction, unit parsing, automated testing, and workspace-based package organization.

## Features

- 🔎 Search for cocktails by name
- 🍹 Display cocktail information such as:
  - Cocktail name
  - Cocktail ID
  - Category
  - Alcoholic/Non-alcoholic status
  - Recommended glass
- 🧾 Display cocktail ingredients and measurements
- 📏 Parse ingredient amounts and units such as:
  - `2 oz`
  - `1/2 oz`
  - `1 1/2 oz`
- 📝 Split cocktail preparation instructions into individual steps
- ⚠️ Detect and display missing instructions
- ❌ Handle invalid API responses and network errors
- 💻 Provide an interactive command-line interface
- 🎨 Use terminal colors for better readability
- 🧪 Include automated tests for API and ingredient parsing functionality
- 📦 Organized as a Dart Pub workspace containing multiple packages

## Project Structure

```text
recipe_mixology_assistant_workspace/
│
├── cocktail_api/
│   ├── lib/
│   │   ├── cocktail_api.dart
│   │   └── src/
│   │       ├── client.dart
│   │       ├── exceptions.dart
│   │       └── models.dart
│   ├── test/
│   │   └── api_test.dart
│   └── pubspec.yaml
│
├── cocktail_cli/
│   ├── bin/
│   │   └── main.dart
│   ├── lib/
│   │   └── src/
│   │       ├── command_base.dart
│   │       ├── commands.dart
│   │       ├── ingredient_parser.dart
│   │       └── logging_config.dart
│   ├── test/
│   │   └── ingredient_parser_test.dart
│   └── pubspec.yaml
│
├── terminal_colors/
│   ├── lib/
│   │   └── terminal_colors.dart
│   └── pubspec.yaml
│
├── pubspec.yaml
├── README.md
└── run_checks.ps1
```

## Packages

### `cocktail_api`

This package is responsible for communicating with TheCocktailDB API. It contains the cocktail models, JSON deserialization logic, API client, and exception handling.

### `cocktail_cli`

This package provides the interactive terminal application. It contains the available commands, ingredient parser, instruction parser, logging configuration, and command-line interface.

### `terminal_colors`

This is a small local package that provides colored terminal output for headers, success messages, warnings, and errors.

## Available Commands

After launching the application, users can enter:

```text
help
```

Displays the available commands.

```text
query Margarita
```

Searches for the Margarita cocktail and displays its recipe information.

```text
query Mojito
```

Searches for the Mojito cocktail.

```text
exit
```

Closes the application.

## Example

```text
Welcome to the Recipe Mixology Assistant!
Type "help" for commands or "exit" to leave.

[mixology] > query Margarita

========== Margarita ==========
ID: 11007
Category: Ordinary Drink
Alcoholic: Alcoholic
Glass: Cocktail glass

INGREDIENTS
  • 1 1/2 oz Tequila
    Parsed amount: 1.5 oz
  • 1 oz Lime juice
    Parsed amount: 1.0 oz

INSTRUCTIONS
  1. Shake with ice and strain.
==========================================
```

If a cocktail does not contain preparation instructions, the application displays:

```text
INSTRUCTIONS
  No instructions provided.
```

## Testing

The project includes automated tests for:

- Cocktail JSON deserialization
- Invalid cocktail data
- API server errors
- Empty API search results
- Ounce measurements
- Simple fractions
- Mixed fractions
- Missing instructions
- Splitting instructions into multiple steps

Run the tests from the project root:

```powershell
dart test
```

## Code Quality Checks

The project can be checked using:

```powershell
dart pub get
dart format .
dart analyze
dart test
```

The included PowerShell script can also run the checks:

```powershell
.\run_checks.ps1
```

## Running the Application

From the root folder, run:

```powershell
dart pub get
dart run --directory cocktail_cli
```

Alternatively:

```powershell
cd cocktail_cli
dart run
```

Then use commands such as:

```text
help
query Margarita
query Mojito
exit
```

## Technologies Used

- **Dart**
- **Dart Pub Workspace**
- **TheCocktailDB API**
- **HTTP**
- **JSON**
- **Logging**
- **Dart Test**
- **PowerShell**

## Purpose of the Project

The main purpose of this project is to demonstrate how Dart can be used to build a practical command-line application that communicates with an external API. It combines API communication, data modeling, parsing, error handling, testing, and user interaction into one organized software project.

## Conclusion

The Recipe Mixology Assistant provides a simple and interactive way to search for cocktail recipes from the terminal. Its modular workspace structure separates API functionality, command-line functionality, and terminal styling, making the project easier to understand, test, and maintain. The project also demonstrates good development practices through automated testing, code formatting, static analysis, and error handling.
