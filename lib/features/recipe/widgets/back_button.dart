import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/recipe/widgets/content_wrap.dart';
import 'dart:math' as math;

class BackButton extends ConsumerWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    return AnimatedContainer(
      duration: kDur,
      width: 192,
      height: 64,
      curve: kCurve,
      child: AnimatedOpacity(
        opacity: 1,
        duration: kDur,
        curve: kCurve,
        child: OverflowBox(
          maxWidth: double.infinity,
          child: LegendButton(
            background: theme.colors.primary,
            borderRadius: BorderRadius.circular(24),
            text: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LegendText(
                  "Back",
                  selectable: false,
                  style: theme.typography.h1,
                  color: theme.appBarColors.foreground,
                ),
                const SizedBox(
                  width: 8,
                ),
                Transform.rotate(
                  angle: math.pi * 0.5,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: theme.appBarColors.foreground,
                  ),
                ),
              ],
            ),
            onTap: () {
              ref.read(indexProvider.notifier).update(
                    (state) => state - 1 >= 0 ? state - 1 : state,
                  );
            },
          ),
        ),
      ),
    );
  }
}
