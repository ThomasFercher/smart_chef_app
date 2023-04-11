import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/recipe/widgets/back_button.dart';
import 'package:smart_chef_app/features/recipe/widgets/continue_button.dart';
import 'dart:math' as math;

import 'package:smart_chef_app/features/recipe/widgets/generate_recipe.dart';

const kDur = Duration(milliseconds: 300);
const kCurve = Curves.easeInOut;

final indexProvider = StateProvider<int>((ref) {
  print("indexProvider created");
  return 0;
});

class ContentWrap extends ConsumerWidget {
  final Widget child;
  final int sectionLength;

  const ContentWrap({
    super.key,
    required this.child,
    required this.sectionLength,
  });
  Widget getButtons(int index, WidgetRef ref) {
    print(ref.read(indexProvider));
    switch (index) {
      case 0:
        return ContinueButton(sectionLength);
      case 1:
        return GenerateRecipe(sectionLength);
      case 2:
        return Row(
          children: [
            const GoBack(),
          ],
        );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context, ref) {
    final sizeInfo = SizeInfo.of(context);
    final theme = LegendTheme.of(context);
    final height = sizeInfo.height;
    final RouteBodyInfo routeBodyInfo = RouteBodyInfo.of(context);

    ref.listen<int>(indexProvider, (index, nextIndex) {
      var position = height;
      if ((index == 0 && nextIndex == 1) || (index == 2 && nextIndex == 1)) {
        position += theme.appBarSizing.appBarHeight / 2;
      }
      routeBodyInfo.scrollController.animateTo(
        position * nextIndex,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
    final index = ref.watch(indexProvider);

    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          right: theme.sizing.spacing1,
          bottom: theme.sizing.spacing1,
          child: getButtons(index, ref),
        ),
      ],
    );
  }
}
