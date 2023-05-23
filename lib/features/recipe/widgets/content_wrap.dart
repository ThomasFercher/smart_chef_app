import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';

import 'package:smart_chef_app/features/recipe/widgets/nav_button.dart';

const kDur = Duration(milliseconds: 200);
const kCurve = Curves.easeInOut;

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

class ContentWrap extends ConsumerWidget {
  final Widget child;
  final int sectionLength;
  final void Function(int index) onPageChanged;

  const ContentWrap({
    super.key,
    required this.child,
    required this.sectionLength,
    required this.onPageChanged,
  });

  Widget _getButtons(int index, bool checkRecipe) {
    final backVisible = index != 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedOpacity(
          opacity: backVisible ? 1 : 0,
          duration: kDur,
          curve: kCurve,
          child: AnimatedScale(
            scale: backVisible ? 1 : 0,
            duration: kDur,
            curve: kCurve,
            child: NavButton(
              onTap: () {
                onPageChanged(index - 1);
              },
              icon: switch (index) {
                1 => Icons.close,
                _ => Icons.arrow_upward,
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        NavButton(
          onTap: () {
            if (index < sectionLength - 1) onPageChanged(index + 1);
            if (index == sectionLength - 1) print("Save");
          },
          icon: switch (index) {
            0 => Icons.add,
            _ when index == sectionLength - 1 => Icons.save,
            _ => Icons.arrow_downward,
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    final index = ref.watch(indexProvider);
    // final checkRecipe = ref.watch(checkRecipeProvider);

    return SizedBox(
      height: context.viewportHeight,
      child: Stack(
        children: [
          child,
          Positioned(
            right: theme.sizing.spacing1,
            bottom: theme.sizing.spacing1,
            child: _getButtons(index, false),
          ),
        ],
      ),
    );
  }
}
