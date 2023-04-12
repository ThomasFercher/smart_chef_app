import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:smart_chef_app/features/recipe/widgets/content_wrap.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';
import 'dart:math' as math;
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';
import 'package:smart_chef_app/services/models/recipe.dart';

class GenerateRecipe extends ConsumerWidget {
  final int sectionLength;

  const GenerateRecipe(this.sectionLength, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIngredients = ref.watch(selectedIngredient);
    final theme = LegendTheme.of(context);
    return AnimatedContainer(
      duration: kDur,
      width: 192,
      height: 64,
      curve: kCurve,
      child: AnimatedOpacity(
        opacity: 1,
        duration: kDur,
        curve: kCurve,
        child: OverflowBox(
          maxWidth: double.infinity,
          child: LegendButton(
            background: theme.colors.primary,
            borderRadius: BorderRadius.circular(24),
            text: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LegendText(
                  "Generate Recipe",
                  selectable: false,
                  style: theme.typography.h1,
                  color: theme.appBarColors.foreground,
                ),
                const SizedBox(
                  width: 8,
                ),
                Transform.rotate(
                  angle: math.pi * 1.5,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: theme.appBarColors.foreground,
                  ),
                ),
              ],
            ),
            onTap: () {
              // List<String> ingedients = [];
              // selectedIngredients.map((e) => ingedients.add(e.name!)).toList();
              // Recipe recipe = Recipe([], [], 2, "Hard", "Selected", null);
              // ref.read(recipeProvider.notifier).getRecipe(recipe);
              ref.read(indexProvider.notifier).state += 1;
              // ref.read(indexProvider.notifier).update(
              //       (state) => state + 1 < sectionLength ? state + 1 : state,
              //     );
            },
          ),
        ),
      ),
    );
  }
}
