import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/category_widget.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_search.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_widget.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/selected_ingredient_widget.dart';

class SelectIngredientsSection extends LegendWidget {
  const SelectIngredientsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return Container(
      width: SizeInfo.of(context).width,
      padding: EdgeInsets.all(
        theme.sizing.spacing1,
      ),
      child: Container(
        color: theme.colors.background1,
        padding: EdgeInsets.all(theme.sizing.spacing2),
        child: Column(
          children: [
            LegendText(
              "Select your ingredients",
              style: theme.typography.h4,
            ),
            const IngredientSearch(),
            SizedBox(height: theme.sizing.spacing1),
            const CategoryWidget(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IngredientWidget(),
                  SelectedIngredientWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
