import 'package:flutter/material.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';

class SmartBackButton extends LegendWidget {
  const SmartBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return ElevatedCard(
      width: 48,
      height: 48,
      elevation: 1,
      background: theme.colors.background1,
      borderRadius: theme.sizing.radius2.asRadius(),
      margin: const EdgeInsets.all(12),
      child: LegendAnimatedIcon(
        icon: Icons.arrow_back_sharp,
        theme: LegendAnimtedIconTheme(
          enabled: theme.colors.selection,
          disabled: theme.colors.foreground1,
        ),
        disableShadow: true,
        onPressed: () {
          LegendRouter.of(context).popPage();
        },
      ),
    );
  }
}
