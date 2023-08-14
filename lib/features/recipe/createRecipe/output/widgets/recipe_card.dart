import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:smart_chef_app/services/models/api_ingredient.dart';

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
