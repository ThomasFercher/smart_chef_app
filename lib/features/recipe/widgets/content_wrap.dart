import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'dart:math' as math;

import 'continue_button.dart';

const kDur = Duration(milliseconds: 300);
const kCurve = Curves.easeInOut;

final indexProvider = StateProvider<int>((ref) {
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
  Widget getButtons(int index) {
    switch (index) {
      case 0:
        return ContinueButton(sectionLength);
      case 1:
        return Row(
          children: [
            BackButton(),
            ContinueButton(sectionLength),
          ],
        );
      case 2:
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
    final showBack = index > 0;
    final showNext = index < sectionLength - 1;
    return Stack(
      fit: StackFit.expand,
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          right: theme.sizing.spacing1,
          bottom: theme.sizing.spacing1,
          child: Row(
            children: [
              AnimatedContainer(
                duration: kDur,
                width: showBack ? 192 : 0,
                height: showBack ? 64 : 0,
                curve: kCurve,
                child: AnimatedOpacity(
                  opacity: showBack ? 1 : 0,
                  duration: kDur,
                  curve: kCurve,
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    child: LegendButton(
                      background: theme.colors.primary,
                      borderRadius: BorderRadius.circular(24),
                      text: showBack
                          ? Row(
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
                            )
                          : SizedBox.shrink(),
                      onTap: () {
                        ref.read(indexProvider.notifier).update(
                              (state) => state - 1 >= 0 ? state - 1 : state,
                            );
                      },
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: kDur,
                width: showNext ? 192 : 0,
                height: showNext ? 64 : 0,
                curve: kCurve,
                child: AnimatedOpacity(
                  opacity: showNext ? 1 : 0,
                  duration: kDur,
                  curve: kCurve,
                  child: OverflowBox(
                    maxWidth: double.infinity,
                    child: LegendButton(
                      background: theme.colors.primary,
                      borderRadius: BorderRadius.circular(24),
                      text: showNext
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LegendText(
                                  "Continue",
                                  selectable: false,
                                  style: theme.typography.h1,
                                  color: theme.appBarColors.foreground,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Transform.rotate(
                                  angle: math.pi * 1.5,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: theme.appBarColors.foreground,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      onTap: () {
                        ref.read(indexProvider.notifier).update(
                              (state) =>
                                  state + 1 < sectionLength ? state + 1 : state,
                            );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
