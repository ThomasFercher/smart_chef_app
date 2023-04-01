// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const kDuration = Duration(milliseconds: 200);
const kStringCheckPath = "assets/icons/check.svg";
const kCurve = Curves.easeOutCubic;

final isSelectedProvider = StateProvider<bool?>((ref) => null);
final isHoveredProvider = StateProvider<bool>((ref) => false);

class LegendCheckbox extends HookConsumerWidget {
  final double size;
  final Color? color;
  final Border? border;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? activeBorderColor;
  final void Function(bool value)? onChanged;
  final bool initalValue;

  const LegendCheckbox({
    super.key,
    this.size = 20,
    this.color,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.borderColor,
    this.activeBorderColor,
    this.onChanged,
    this.initalValue = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    final controller = useAnimationController(
      duration: kDuration,
    );
    final curvedController = CurvedAnimation(parent: controller, curve: kCurve);
    final _borderColor = borderColor ?? theme.colors.disabled;
    final _borderActiveColor = activeBorderColor ?? theme.colors.selection;

    final borderAnimation = ColorTween(
      begin: _borderColor,
      end: _borderActiveColor,
    ).animate(curvedController);

    final checkScaleAnimation = Tween<double>(
      begin: 0,
      end: 0.68,
    ).animate(curvedController);

    ref.listen<bool?>(isSelectedProvider, (prev, state) {
      if (state == null) return;
      onChanged?.call(state);
      if (state) {
        controller.forward();
        return;
      }
      controller.reverse();
    });

    useEffect(() {
      if (initalValue) controller.forward();
      return null;
    }, [initalValue]);

    return SizedBox(
      width: size,
      height: size,
      child: MouseRegion(
        onEnter: (event) => ref.read(isHoveredProvider.notifier).state = true,
        onExit: (event) => ref.read(isHoveredProvider.notifier).state = false,
        child: GestureDetector(
          onTap: () {
            ref.read(isSelectedProvider.notifier).update(
                  (state) => !(state ?? initalValue),
                );
          },
          child: AnimatedBuilder(
            animation: curvedController,
            builder: (context, child) {
              final color = borderAnimation.value ?? Colors.black;
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: border ??
                      Border.all(
                        color: color,
                      ),
                ),
                child: Transform.scale(
                  scale: checkScaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: SvgPicture.asset(
              kStringCheckPath,
              width: size,
              height: size,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
