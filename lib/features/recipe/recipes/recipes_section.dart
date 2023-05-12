import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';

class RecipeSection extends StatelessWidget {
  const RecipeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final recipes = [];
    return Container(
      height: context.viewportHeight,
      padding: EdgeInsets.all(theme.sizing.spacing1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LegendText(
            "Recipes",
            style: theme.typography.h5,
          ),
          if (recipes.isNotEmpty)
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (var recipe in recipes)
                    //    RecipeWidget(recipe: recipe)
                    SizedBox(),
                ],
              ),
            )
          else
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Icon(
                    Icons.sentiment_dissatisfied_outlined,
                    size: 48,
                    color: theme.colors.foreground2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: LegendText(
                      "No Recipes Found",
                      style: theme.typography.h2,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 72,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LegendText(
                                    "Create a recipe to get started",
                                    style: theme.typography.h2,
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    size: 48,
                                    color: theme.colors.foreground3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
