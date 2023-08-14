import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:legend_design_widgets/datadisplay/badge/legendBadge.dart';

class SelectedIngredients extends ConsumerWidget {
  const SelectedIngredients({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIngredients = ref.watch(selectedIngredientProvider);
    final itemCount = selectedIngredients.length;

    if (itemCount == 0) {
      return SizedBox(
        height: 140,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sentiment_dissatisfied,
                size: 48,
              ),
              const SizedBox(height: 16.0),
              LegendText(
                'No ingredients selected',
                textAlign: TextAlign.center,
                style: context.theme.typography.h2,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: selectedIngredients.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        return SelectedIngredientTile(ingredient: selectedIngredients[index]);
      },
    );
  }
}

class SelectedIngredientTile extends ConsumerWidget {
  final SelectedIngredient ingredient;
  const SelectedIngredientTile({super.key, required this.ingredient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    return SizedBox(
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LegendText(
            ingredient.ingredient.name,
            color: theme.colors.onSecondary,
            textAlign: TextAlign.center,
            style: context.theme.typography.h3,
          ),
          const Spacer(),
          LegendText(
            "${ingredient.quantity}",
            color: theme.colors.onSecondary,
            textAlign: TextAlign.center,
            style: context.theme.typography.h3,
          ),
          const SizedBox(width: 24.0),
          LegendAnimatedIcon(
            disableShadow: true,
            icon: Icons.remove_circle,
            iconSize: 24,
            theme: LegendAnimtedIconTheme(
              enabled: theme.colors.selection,
              disabled: theme.colors.disabled,
            ),
            onPressed: () => ref
                .read(selectedIngredientProvider.notifier)
                .removeIngredient(ingredient),
          ),
          LegendAnimatedIcon(
            disableShadow: true,
            icon: Icons.add_circle,
            padding: EdgeInsets.zero,
            iconSize: 24,
            theme: LegendAnimtedIconTheme(
              enabled: theme.colors.selection,
              disabled: theme.colors.disabled,
            ),
            onPressed: () => ref
                .read(selectedIngredientProvider.notifier)
                .addIngredient(ingredient),
          ),
        ],
      ),
    );
  }
}
