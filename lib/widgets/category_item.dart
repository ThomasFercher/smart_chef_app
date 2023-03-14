import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';

class CategoryItem extends LegendWidget {
  final Widget child;

  const CategoryItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return child;
  }
}
