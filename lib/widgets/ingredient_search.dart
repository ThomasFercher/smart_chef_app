import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:legend_design_core/state/legend_state.dart';

class IngredientSearch extends LegendWidget {
  const IngredientSearch({super.key});

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return SizedBox(
      height: 50,
      child: Placeholder(
        color: theme.colors.foreground1,
      ),
    );
  }
}
