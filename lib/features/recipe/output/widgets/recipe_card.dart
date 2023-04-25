import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_utils/extensions/extensions.dart';

class RecipeCard extends StatelessWidget {
  final List<Widget> children;
  const RecipeCard(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    return Card(
      elevation: 3.0,
      color: theme.colors.background1,
      shape: RoundedRectangleBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {
  final Widget child;
  const IngredientCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
