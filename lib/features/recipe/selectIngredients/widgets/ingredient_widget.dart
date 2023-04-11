import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
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
        return SizedBox(
          width: SizeInfo.of(context).width * 0.3,
          child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: theme.colors.background2,
            child: ScrollConfiguration(
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
                  color: theme.colors.foreground1,
                ),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: theme.sizing.spacing1),
                    child: IngredientTile(
                      ingredient: ingredients[index],
                    ),
                  );
                },
              ),
            ),
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
    );
  }
}
