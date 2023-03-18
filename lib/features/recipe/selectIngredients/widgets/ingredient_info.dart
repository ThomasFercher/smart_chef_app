import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/services/model/ingredient.dart';

import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/nutritional_value_chart.dart';

class IngredienInfo extends LegendWidget {
  final Ingredient ingredient;
  const IngredienInfo({Key? key, required this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: theme.colors.background2,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            color: theme.colors.background3,
            width: SizeInfo.of(context).width * 0.3,
            height: SizeInfo.of(context).width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LegendText(
                  "Nutritional value",
                  style: theme.typography.h3,
                  color: theme.colors.foreground1,
                ),
                NutritionChart(
                  ingredient: ingredient,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
