import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_info.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';
import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:smart_chef_app/services/models/recipe.dart';

class SelectedIngredientWidget extends ConsumerWidget {
  const SelectedIngredientWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final selectedIngredients = ref.watch(selectedIngredient);
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
          child: Column(
            children: [
              LegendText(
                "Selected Ingredients",
                style: theme.typography.h3,
              ),
              SizedBox(
                width: 200,
                child: LegendButton.text(
                    text: "Generate Recipe",
                    style: TextStyle(
                        color: theme.colors.onSecondary, fontSize: 16),
                    background: theme.colors.primary,
                    onTap: () {
                      List<String> ingedients = [];
                      selectedIngredients
                          .map((e) => ingedients.add(e.name!))
                          .toList();
                      Recipe recipe =
                          Recipe([], [], 2, "Hard", "Selected", null);
                      ref.read(recipeProvider.notifier).getRecipe(recipe);
                      /*    showDialog(
                        context: context,
                        builder: (context) => FutureBuilder(
                          future: ApiService.postRecipe(recipe),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              RecipeResponse response =
                                  snapshot.data as RecipeResponse;

                              List processedItems =
                                  response.ingredients.map((item) {
                                return item.values.map((part) {
                                  return part.replaceAll(RegExp('[{}"]+'), '');
                                }).toList();
                              }).toList();

                              return AlertDialog(
                                title: Text(response.name),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LegendText(
                                      "Ingredients: ",
                                      style: theme.typography.h2,
                                    ),
                                    ...processedItems
                                        .map((item) => Text("- $item"))
                                        .toList(),
                                    LegendText(
                                      "Tools: ",
                                      style: theme.typography.h2,
                                    ),
                                    ...response.tools
                                        .map((item) => Text("- $item"))
                                        .toList(),
                                    LegendText(
                                      "Steps: ",
                                      style: theme.typography.h2,
                                    ),
                                    ...response.steps
                                        .map((item) => Text("- $item"))
                                        .toList(),
                                    LegendText(
                                      "Tips: ",
                                      style: theme.typography.h2,
                                    ),
                                    ...response.tips
                                        .map((item) => Text("- $item"))
                                        .toList(),
                                  ],
                                ),
                              );
                            }
                            return Center(
                                child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator()));
                          },
                        ),
                      );*/
                    }),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: theme.colors.foreground1,
                  ),
                  itemCount: selectedIngredients.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: theme.sizing.spacing1),
                        child: SelectedIngredientTile(
                            ingredient: selectedIngredients[index]));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedIngredientTile extends ConsumerWidget {
  final Ingredient ingredient;
  const SelectedIngredientTile({super.key, required this.ingredient});
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
              onPressed: () {
                ingredientNotifier.removeIngredient(ingredient);
              },
              icon: Icon(
                Icons.remove_circle_outline,
                color: theme.colors.foreground1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
