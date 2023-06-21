import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:legend_design_widgets/datadisplay/badge/legendBadge.dart';

class SelectedIngredients extends ConsumerWidget {
  const SelectedIngredients({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final selectedIngredients = ref.watch(selectedIngredientProvider);
    return ListView.builder(
      itemCount: selectedIngredients.length,
      itemBuilder: (context, index) {
        return SelectedIngredientTile(ingredient: selectedIngredients[index]);
      },
    );
  }
}

class SelectedIngredientTile extends ConsumerWidget {
  final Ingredient ingredient;
  const SelectedIngredientTile({super.key, required this.ingredient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    return LegendBadge(
      badge: LegendAnimatedIcon(
        disableShadow: true,
        icon: Icons.remove_circle,
        theme: LegendAnimtedIconTheme(
          enabled: theme.colors.selection,
          disabled: theme.colors.disabled,
        ),
        onPressed: () => ref
            .read(selectedIngredientProvider.notifier)
            .removeIngredient(ingredient),
      ),
      content: SizedBox(
        height: 64,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: theme.sizing.radius1.asRadius(),
          ),
          elevation: 3.0,
          color: theme.colors.secondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 12.0),
                LegendText(
                  ingredient.name,
                  color: theme.colors.onSecondary,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
