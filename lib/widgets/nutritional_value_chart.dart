import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smart_chef_app/content/model/ingredient.dart';

class NutritionChart extends LegendWidget {
  Ingredient ingredient;
  NutritionChart({Key? key, required this.ingredient}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    Map<String, double> dataMap = {
      "carbohydrates": ingredient.carbohydrates!,
      "protein": ingredient.protein!,
      "fat": ingredient.fat!,
    };
    return PieChart(
      chartRadius: SizeInfo.of(context).width * 0.1,
      chartType: ChartType.ring,
      legendOptions: LegendOptions(
        legendTextStyle: TextStyle(
          color: theme.colors.foreground1,
        ),
        legendPosition: LegendPosition.bottom,
        showLegendsInRow: true,
      ),
      dataMap: dataMap,
    );
  }
}
