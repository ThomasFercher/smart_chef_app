import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_utils/legend_utils.dart';

class IconContainer extends LegendWidget {
  final String title;
  final double size;

  const IconContainer({
    super.key,
    required this.size,
    required this.title,
  });

  @override
  Widget build(BuildContext context, theme) {
    return ElevatedBox(
      elevation: 1,
      decoration: BoxDecoration(
        color: theme.colors.background4,
        borderRadius: theme.sizing.radius2.asRadius(),
      ),
      padding: EdgeInsets.all(theme.sizing.spacing1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LegendText(
            title,
            style: theme.typography.h1.copyWith(
              color: theme.colors.foreground4,
            ),
          ),
          SizedBox(
            width: theme.sizing.spacing1,
          ),
          Icon(
            Icons.troubleshoot_rounded,
            size: size,
            color: theme.colors.foreground4,
          ),
        ],
      ),
    );
  }
}
