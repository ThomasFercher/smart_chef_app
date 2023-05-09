import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:smart_chef_app/features/footer/footer.dart';

const kDuration = Duration(milliseconds: 300);

class AppBarMenuItem extends LegendWidget {
  final bool isActive;
  final String title;
  final IconData? icon;
  final void Function()? onTap;

  const AppBarMenuItem({
    Key? key,
    required this.isActive,
    required this.title,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    final radius = theme.sizing.radius1;
    return LegendDetector(
      onTap: onTap,
      background: theme.colors.secondary,
      borderRadius: radius.asRadius(),
      child: Container(
        width: 120,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedPositioned(
              duration: kDuration,
              top: 0,
              bottom: isActive ? radius : 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LegendText(
                    title,
                    style: theme.typography.h2,
                    color: theme.colors.onSecondary,
                    selectable: false,
                  ),
                  if (icon != null) ...[
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      icon,
                      size: 22,
                      color: theme.colors.primary.ifElse(
                        isActive,
                        theme.colors.onSecondary,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedOpacity(
                opacity: isActive ? 1 : 0,
                duration: kDuration,
                child: Container(
                  height: radius,
                  decoration: BoxDecoration(
                    color: theme.colors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(radius),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
