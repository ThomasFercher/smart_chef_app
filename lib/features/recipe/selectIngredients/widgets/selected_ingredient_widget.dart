import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_info.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';
import 'package:smart_chef_app/services/api_service.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';
import 'package:smart_chef_app/services/models/recipe.dart';
import 'package:legend_design_widgets/datadisplay/badge/legendBadge.dart';

class SelectedIngredientWidget extends ConsumerWidget {
  const SelectedIngredientWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final selectedIngredients = ref.watch(selectedIngredient);
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: theme.colors.background1,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: const ClampingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.trackpad,
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: selectedIngredients.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: SelectedIngredientTile(
                      ingredient: selectedIngredients[index]),
                ),
              );
            },
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
    final theme = LegendTheme.of(context);
    return LegendBadge(
      badge: LegendAnimatedIcon(
        disableShadow: true,
        icon: Icons.remove_circle,
        theme: LegendAnimtedIconTheme(
          enabled: theme.colors.selection,
          disabled: theme.colors.disabled,
        ),
        onPressed: () =>
            ref.read(selectedIngredient.notifier).removeIngredient(ingredient),
      ),
      content: SizedBox(
        width: 100.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: theme.sizing.radius1.asRadius(),
          ),
          elevation: 3.0,
          color: theme.colors.secondary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/${ingredient.category}.png',
                  ),
                ),
                LegendText(
                  ingredient.name,
                  color: theme.colors.foreground5,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
