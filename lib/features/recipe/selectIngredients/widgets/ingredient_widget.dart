import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:smart_chef_app/services/model/ingredient.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/category_widget.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_info.dart';

import '../../../../providers/ingredient_provider.dart';

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
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              height: 2,
              color: theme.colors.background2,
            ),
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              return IngredientTile(ingredient: ingredients[index]);
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