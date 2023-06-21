import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/output/widgets/recipe_card.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';
import 'package:smart_chef_app/services/models/api_ingredient.dart';
import 'package:smart_chef_app/services/models/recipe.dart';

class OutputSection extends ConsumerWidget {
  const OutputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final recipeState = ref.watch(recipeProvider);
    RecipeNotifier notifier = ref.read(recipeProvider.notifier);

    List<ApiIngredient> ingredients = [];
    for (var ingredient in ref.watch(selectedIngredient)) {
      ingredients.add(ApiIngredient(ingredient.name, "one"));
    }
    notifier.getRecipe(
        Recipe(ingredients, [], 1, "difficulty", "slection", "kitchen"));

    return recipeState.when(
      data: (recipe) {
        return SizedBox(
          height: context.viewportHeight,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                physics: const ClampingScrollPhysics(),
                dragDevices: {
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  LegendText(
                    recipe.name,
                    style: theme.typography.h4,
                  ),
                  Card(
                    elevation: 2.0,
                    color: theme.colors.background1,
                    shape: RoundedRectangleBorder(
                      borderRadius: theme.sizing.radius1.asRadius(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LegendText("Ingredients", style: theme.typography.h3),
                          SizedBox(
                            height: theme.sizing.spacing1,
                          ),
                          DynamicRow(
                            children: [
                              for (final ingredient in recipe.ingredients)
                                IngredientCard(
                                  child: LegendText(
                                    "${ingredient.name} - ${ingredient.amount}",
                                    style: theme.typography.h2,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: theme.sizing.spacing3,
                          ),
                          LegendText("Tools", style: theme.typography.h3),
                          SizedBox(
                            height: theme.sizing.spacing1,
                          ),
                          DynamicRow(
                            children: [
                              for (final tool in recipe.tools)
                                IngredientCard(
                                  child: LegendText(tool.toString(),
                                      style: theme.typography.h2),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: theme.sizing.spacing3,
                          ),
                          LegendText("Steps", style: theme.typography.h3),
                          SizedBox(
                            height: theme.sizing.spacing1,
                          ),
                          for (final step in recipe.steps)
                            LegendText(step.toString(),
                                style: theme.typography.h2),
                          SizedBox(
                            height: theme.sizing.spacing3,
                          ),
                          LegendText("Tips", style: theme.typography.h3),
                          SizedBox(
                            height: theme.sizing.spacing1,
                          ),
                          for (final tip in recipe.tips)
                            LegendText(tip.toString(),
                                style: theme.typography.h2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () {
        return SizedBox(
          height: context.viewportHeight,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stack) {
        return Center(
          child: LegendText(
            error.toString(),
          ),
        );
      },
    );
  }
}
