import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_checkbox.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/select_info_providers.dart';

class DifficultyCard extends LegendWidget {
  final String title;
  final IngredientModeDescription? description;
  final bool selected;
  final void Function()? onTap;

  const DifficultyCard({
    Key? key,
    required this.title,
    this.description,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return ElevatedCard(
      onTap: onTap,
      elevation: 1,
      background: theme.colors.background3,
      borderRadius: theme.sizing.radius1.asRadius(),
      child: Container(
        height: 120,
        //  width: 240,
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: LegendText(
                title,
                style: theme.typography.h3,
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: LegendCheckboxNoState(
                value: selected,
                onChanged: (value) {
                  onTap?.call();
                },
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: LegendText(description?.label, style: theme.typography.h1),
            ),
          ],
        ),
      ),
    );
  }
}
