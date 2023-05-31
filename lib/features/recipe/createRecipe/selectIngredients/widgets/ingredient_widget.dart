import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/animated_card.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/ingredient_info.dart';

class IngredientWidget extends ConsumerWidget {
  const IngredientWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ingredientDataProvider);

    final theme = LegendTheme.of(context);
    return data.when(
      data: (ingredients) {
        final categories = ref.watch(selectedCategoriesProvider);
        final searchText = ref.watch(searchTextProvider);

        final filteredList = ingredients
            .where((ingredient) => categories
                .contains(ingredient.category)
                .ifElse(categories.isNotEmpty, true))
            .where((ingredient) => ingredient.name
                .toLowerCase()
                .contains(searchText.toLowerCase().trim())
                .ifElse(searchText.isNotEmpty, true))
            .toList();

        return SliverList.separated(
          itemCount: filteredList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final ingredient = filteredList[index];
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == filteredList.length - 1 ? 64 : 0),
              child: IngredientTile(
                ingredient: ingredient,
              ),
            );
          },
        );
      },
      error: (err, s) => SliverFillRemaining(
        child: Center(
          child: Text(
            err.toString(),
          ),
        ),
      ),
      loading: () => const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
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
      height: 54,
      background: theme.colors.background4,
      borderRadius: theme.sizing.radius1.asRadius(),
      padding: const EdgeInsets.only(
        left: 16,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
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
          const SizedBox(
            width: 8,
          ),
          LegendAnimatedIcon(
            icon: Icons.add,
            iconSize: 26,
            padding: const EdgeInsets.all(8),
            theme: LegendAnimtedIconTheme(
              enabled: theme.colors.selection,
              disabled: theme.colors.foreground1,
            ),
            disableShadow: true,
            onPressed: () {
              ingredientNotifier.addIngredient(ingredient);
            },
          ),
        ],
      ),
    );
  }
}
