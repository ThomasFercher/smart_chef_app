import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_utils/legend_utils.dart';

class ColorContainer extends LegendWidget {
  final Color color;
  final String? title;
  final double size;

  const ColorContainer({
    super.key,
    required this.color,
    this.title,
    this.size = 128,
  });

  @override
  Widget build(BuildContext context, theme) {
    return ElevatedBox(
      elevation: theme.sizing.elevation2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: theme.sizing.radius2.asRadius(),
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: LegendText(
            title,
            style: theme.typography.h2.copyWith(
              color: color.getTextColor(
                light: Colors.white,
                dark: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
