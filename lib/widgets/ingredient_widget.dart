import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:smart_chef_app/widgets/category_widget.dart';
import 'package:smart_chef_app/widgets/ingredient_info.dart';
import '../content/model/ingredient.dart';
import '../content/providers/ingredient_provider.dart';

class IngredientWidget extends ConsumerWidget {
  const IngredientWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ingredientDataProvider);
    final Set<String> categories = {};
    return data.when(
      data: (ingredients) {
        for (final ingredient in ingredients) {
          categories.add(ingredient.category!);
        }
        final sorted = SplayTreeSet.from(categories);
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: CategoryWidget(sorted),
            ),
            Expanded(
              flex: 4,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const IngredientSeperator(),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return IngredientTile(ingredient: ingredients[index]);
                },
              ),
            ),
          ],
        );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class IngredientTile extends LegendWidget {
  final Ingredient ingredient;
  const IngredientTile({super.key, required this.ingredient});
  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: LegendText(
            ingredient.name,
            color: theme.colors.foreground1,
          ),
        ),
        IngredienInfo(
          ingredient: ingredient,
        ),
      ],
    );
  }
}

class IngredientSeperator extends LegendWidget {
  const IngredientSeperator({super.key});
  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return Divider(
      height: 2,
      color: theme.colors.background2,
    );
  }
}
