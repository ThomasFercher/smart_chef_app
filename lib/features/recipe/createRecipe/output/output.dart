import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:smart_chef_app/features/home/home.dart';
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

    final body = GoogleFonts.indieFlower(
      fontSize: 24,
      color: theme.colors.foreground1,
    );

    final headline = GoogleFonts.indieFlower(
      fontSize: 42,
      fontWeight: FontWeight.w900,
      color: theme.colors.foreground1,
    );

    final s1 = theme.rVal(s: 24, m: 24, l: 32, xl: 32);

    return recipeState.when(
      data: (recipe) {
        return ElevatedCard(
          background: theme.colors.background2,
          elevation: 1,
          borderRadius: theme.sizing.radius1.asRadius(),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LegendText(
                    recipe.name,
                    style: headline.copyWith(fontSize: 48),
                  ),
                  s1.vSpacing,
                  LegendText("Ingredients", style: headline),
                  s1.vSpacing,
                  DynamicRow(
                    hSpacing: 32,
                    children: [
                      for (final ingredient in recipe.ingredients)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: LegendText(
                            "${ingredient.name} - ${ingredient.amount} ;",
                            style: body,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: theme.sizing.spacing3,
                  ),
                  LegendText("Tools", style: headline),
                  SizedBox(
                    height: theme.sizing.spacing1,
                  ),
                  DynamicRow(
                    children: [
                      for (final tool in recipe.tools)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: LegendText(
                            "$tool ;",
                            style: body,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: theme.sizing.spacing3,
                  ),
                  LegendText(
                    "Steps",
                    style: headline,
                  ),
                  SizedBox(
                    height: theme.sizing.spacing1,
                  ),
                  for (final step in recipe.steps) ...[
                    Row(
                      children: [
                        SizedBox(
                          width: theme.sizing.spacing2,
                        ),
                        Icon(
                          Icons.circle,
                          color: theme.colors.primary,
                        ),
                        SizedBox(
                          width: theme.sizing.spacing3,
                        ),
                        Expanded(
                          child: LegendText(
                            step.toString(),
                            style: body,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                  SizedBox(
                    height: theme.sizing.spacing3,
                  ),
                  LegendText("Tips", style: headline),
                  SizedBox(
                    height: theme.sizing.spacing1,
                  ),
                  for (final tip in recipe.tips)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: LegendText(tip.toString(), style: body),
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
    );
  }
}
