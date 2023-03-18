import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';

class IngredientSearch extends LegendWidget {
  const IngredientSearch({super.key});

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return Container(
        padding: EdgeInsets.all(theme.sizing.spacing1),
        child: TextField(
          decoration: InputDecoration(
            fillColor: theme.colors.background1,
            hintText: 'Enter your ingredient',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: theme.colors.background3),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ));
  }
}
