import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/animated_card.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/ingredient_info.dart';

import '../../../../../providers/ingredient_provider.dart';

class IngredientWidget extends ConsumerWidget {
  const IngredientWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ingredientDataProvider);
    final category = ref.watch(categoryProvider);
    final theme = LegendTheme.of(context);
    return data.when(
      data: (ingredients) {
        if (category != 'Meat') {
          ingredients = ingredients
              .where((element) => element.category == category)
              .toList();
        }
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: const ClampingScrollPhysics(),
            dragDevices: {
              PointerDeviceKind.trackpad,
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 12 : 0,
                  bottom: 12,
                  left: 2,
                  right: 2,
                ),
                child: IngredientTile(
                  ingredient: ingredients[index],
                ),
              );
            },
          ),
        );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class IngredientTile extends ConsumerWidget {
  final Ingredient ingredient;
  const IngredientTile({super.key, required this.ingredient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SelectedIngredientNotifier ingredientNotifier =
        ref.watch(selectedIngredient.notifier);
    final theme = LegendTheme.of(context);
    return AnimatedCard(
      elevation: 1,
      selElevation: 2,
      background: theme.colors.background4,
      borderRadius: theme.sizing.radius1.asRadius(),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: LegendText(
              ingredient.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              color: theme.colors.foreground1,
            ),
          ),
          IngredienInfo(
            ingredient: ingredient,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                splashRadius: 16,
                onPressed: () {
                  ingredientNotifier.addIngredient(ingredient);
                },
                icon: Icon(
                  Icons.add,
                  color: theme.colors.foreground1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
