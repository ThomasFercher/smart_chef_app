import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/category_widget.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/ingredient_search.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/ingredient_widget.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/selected_ingredient_widget.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';

class SelectIngredientsSection extends ConsumerWidget {
  const SelectIngredientsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIngredients = ref.watch(selectedIngredient);
    final theme = LegendTheme.of(context);
    return Container(
      width: SizeInfo.of(context).width,
      height: context.height,
      padding: EdgeInsets.all(theme.sizing.spacing3),
      child: ElevatedCard(
        background: theme.colors.background1,
        padding: EdgeInsets.all(theme.sizing.spacing2),
        borderRadius: theme.sizing.radius1.asRadius(),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendText(
              "Select your Ingredients",
              style: theme.typography.h4,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: CategoryWidget(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const IngredientSearch(),
                        const SizedBox(
                          height: 16,
                        ),
                        const Expanded(flex: 5, child: IngredientWidget()),
                        selectedIngredients.isEmpty
                            ? const SizedBox()
                            : const SelectedIngredientWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
