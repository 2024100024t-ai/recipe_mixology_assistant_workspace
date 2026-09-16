# Recipe Mixology Assistant — Corrected Dart Workspace

This version is organized as a Dart pub workspace so the root folder itself has a `pubspec.yaml`. It contains three packages:

- `cocktail_api` — cocktail model, JSON deserialization, API client, exceptions, API tests.
- `cocktail_cli` — interactive CLI, ingredient/unit parser, instruction parser, command pattern, tests.
- `terminal_colors` — small local styling package required by the CLI.

## Run from the ROOT folder

Open this folder in VS Code and run:

```powershell
dart pub get
dart format .
dart analyze
dart test
```

Then launch the CLI:

```powershell
dart run --directory cocktail_cli
```

Or:

```powershell
cd cocktail_cli
dart run
```

## Commands

```text
help
query Margarita
query Mojito
exit
```

The `query` command displays cocktail ingredients, parsed amounts/units, and preparation instructions. If instructions are absent, it explicitly displays `No instructions provided.`

## Important

Do **not** run `dart pub add cocktail_cli`. `cocktail_cli` is a workspace package, not a dependency on itself.

If `dart pub get` spends a long time downloading `analyzer`, that is the Dart package manager downloading the test/analyzer dependency. The code does not need to be changed for that network download.
