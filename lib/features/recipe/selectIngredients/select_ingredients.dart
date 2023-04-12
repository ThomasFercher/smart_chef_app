import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/category_widget.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_search.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_widget.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/selected_ingredient_widget.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';

class SelectIngredientsSection extends ConsumerWidget {
  const SelectIngredientsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIngredients = ref.watch(selectedIngredient);
    final theme = LegendTheme.of(context);
    return Container(
      color: Colors.red,
      width: SizeInfo.of(context).width,
      height: SizeInfo.of(context).height,
      child: Container(
        color: theme.colors.background1,
        padding: EdgeInsets.all(theme.sizing.spacing2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            LegendText(
              "Select your ingredients",
              style: theme.typography.h4,
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: const CategoryWidget(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        IngredientSearch(),
                        Expanded(child: const IngredientWidget()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: selectedIngredients.isEmpty
            //       ? const IngredientWidget()
            //       : Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: const [
            //             IngredientWidget(),
            //             SelectedIngredientWidget(),
            //           ],
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
