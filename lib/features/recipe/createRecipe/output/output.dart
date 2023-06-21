import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/output/widgets/recipe_card.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'json_template.dart';

class OutputSection extends HookConsumerWidget {
  const OutputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    //final recipeState = ref.watch(recipeProvider);
    final recipeState = AsyncValue.data(sampleRecipe);

    useEffect(() {
      return null;
    }, []);

    // notifier.getRecipe(
    //     Recipe(ingredients, [], 1, "difficulty", "slection", "kitchen"));

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: recipeState.when(
        data: (recipe) {
          return Align(
            alignment: Alignment.topCenter,
            child: ElevatedCard(
              elevation: 2.0,
              background: theme.colors.background2,
              borderRadius: theme.sizing.radius1.asRadius(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LegendText(
                      recipe.name,
                      style: theme.typography.h4,
                    ),
                    LegendText("Ingredients", style: theme.typography.h3),
                    SizedBox(
                      height: theme.sizing.spacing1,
                    ),
                    DynamicRow(
                      children: [
                        for (final ingredient in recipe.ingredients)
                          IngredientCard(ingredient: ingredient),
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
                          ElevatedCard(
                            elevation: 1,
                            child: LegendText(
                              tool.toString(),
                              style: theme.typography.h2,
                            ),
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
                      LegendText(step.toString(), style: theme.typography.h2),
                    SizedBox(
                      height: theme.sizing.spacing3,
                    ),
                    LegendText("Tips", style: theme.typography.h3),
                    SizedBox(
                      height: theme.sizing.spacing1,
                    ),
                    for (final tip in recipe.tips)
                      LegendText(tip.toString(), style: theme.typography.h2),
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
          return SizedBox(
            height: context.viewportHeight,
            child: Center(
              child: LegendText(
                error.toString(),
                style: theme.typography.h2,
              ),
            ),
          );
        },
      ),
    );
  }
}
