// ignore_for_file: constant_identifier_names

library select_info_providers;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/providers/helpers.dart';

bool validateSelectInfo(WidgetRef ref) {
  final toolsValid = ref.read(selectedToolsProvider.notifier).validate();
  final difficultyValid = ref.read(difficultyProvider.notifier).validate();
  final ingredientModeValid =
      ref.read(ingredientModeProvider.notifier).validate();

  if (!toolsValid || !difficultyValid || !ingredientModeValid) {
    return false;
  }

  return true;
}

///
/// Difficulty
///

enum Difficulty {
  Easy("Beginner"),
  Medium("Intermediate"),
  Hard("Advanced");

  final String label;
  const Difficulty(this.label);
}

final difficultyProvider = StateNotifierProvider<
    ValidationNotifier<Difficulty?>, ValidationValue<Difficulty?>>(
  (ref) => ValidationNotifier(
    validator: (value) {
      if (value == null) {
        return "Please select a difficulty";
      }
      return null;
    },
    intialValue: null,
  ),
);

///
/// Ingredient Mode
///

enum IngredientMode {
  random("Random"),
  strict("Strict"),
  stricGen("Strict with Generated Ingredients"),
  selection("Selection");

  final String label;

  const IngredientMode(this.label);
}

enum IngredientModeDescription {
  random(
      "Random Ingredients are selected. The List of ingredients is ignored."),
  strict("Only the given ingredients are used."),
  stricGen(
      "All the given ingredients are used and a few ingredients are generated."),
  selection("Fitting Ingredients are selected and others are generated.");

  final String label;

  const IngredientModeDescription(this.label);
}

final ingredientModeProvider = StateNotifierProvider<
    ValidationNotifier<IngredientMode?>, ValidationValue<IngredientMode?>>(
  (ref) => ValidationNotifier(
    validator: (value) {
      if (value == null) {
        return "Please select an ingredient mode";
      }
      return null;
    },
    intialValue: null,
  ),
);

///
/// Tools
///

final defaultTools = List.of(
  ["Stove", "Airfryer", "Microwave", "Pan", "Pot", "Bowl"],
  growable: true,
);

final toolsProvider = StateProvider<List<String>>((ref) => defaultTools);

final selectedToolsProvider = StateNotifierProvider<
    ValidationNotifier<List<String>>, ValidationValue<List<String>>>(
  (_) {
    return ValidationNotifier(
      validator: (value) {
        if (value.isEmpty) {
          return "Please select at least one tool";
        }
        return null;
      },
      intialValue: [],
    );
  },
);

///
/// Time
///

final minuteProvider = StateProvider<double>((ref) => 60);

///
///  Serving Amount
///

final servingAmountProvider = StateProvider<int?>((ref) => 1);
