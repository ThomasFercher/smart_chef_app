import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final isAddingProvider = StateProvider<bool>((ref) => false);

class AddToolButton extends HookConsumerWidget {
  final void Function(String name) onAdd;

  const AddToolButton({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = context.theme;
    final isAdding = ref.watch(isAddingProvider);
    final ctrl = useTextEditingController();
    final focusNode = useFocusNode();

    final textWidth = getTextWidth(
      ctrl.text,
      theme.typography.h1,
    );

    final width = useState(textWidth);

    useEffect(
      () {
        ctrl.addListener(() {
          width.value = getTextWidth(
            ctrl.text,
            theme.typography.h1,
          );
        });
        return () {
          width.value = 16;
        };
      },
      [],
    );

    return Padding(
      padding: EdgeInsets.only(right: !isAdding ? 48 : 0),
      child: SizedBox(
        height: 48,
        child: LegendDetector(
          background: theme.colors.background4,
          borderRadius: 16.0.asRadius(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isAdding ? 1 : 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    width: isAdding ? width.value + 16 : 0,
                    height: 48,
                    child: Offstage(
                      offstage: !isAdding,
                      child: Center(
                        child: LegendInput(
                          ctrl: ctrl,
                          style: theme.typography.h1,
                          focusNode: focusNode,
                          decoration: asdasdsd(
                            theme,
                            null,
                            hintText: "Enter Tool Name",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isAdding
                      ? LegendAnimatedIcon(
                          onPressed: () {
                            onAdd(ctrl.text);
                            ref.read(isAddingProvider.notifier).state = false;
                            ctrl.text = "";
                          },
                          icon: Icons.check,
                          iconSize: 20,
                          theme: LegendAnimtedIconTheme(
                            enabled: theme.colors.selection,
                            disabled: theme.colors.primary,
                          ),
                        )
                      : Icon(
                          Icons.add,
                          color: theme.colors.primary,
                          size: 20,
                        ),
                ),
                if (isAdding) ...[
                  const SizedBox(width: 8),
                  LegendAnimatedIcon(
                    onPressed: () {
                      ctrl.text = "";
                      ref
                          .read(isAddingProvider.notifier)
                          .update((state) => state ? !state : !state);
                    },
                    icon: Icons.cancel,
                    iconSize: 20,
                    theme: LegendAnimtedIconTheme(
                      enabled: theme.colors.error,
                      disabled: theme.colors.error,
                    ),
                  )
                ]
              ],
            ),
          ),
          onTap: () {
            if (isAdding) return;
            focusNode.requestFocus();
            ref
                .read(isAddingProvider.notifier)
                .update((state) => state ? !state : !state);
          },
        ),
      ),
    );
  }
}

InputDecoration asdasdsd(
  LegendTheme theme,
  String? errorMessage, {
  String? hintText,
}) =>
    InputDecoration(
      hintText: hintText,
      hintStyle: theme.typography.h0.copyWith(
        color: theme.colors.foreground4,
      ),
      errorText: errorMessage,
      errorStyle: theme.typography.h0.copyWith(
        color: theme.colors.error,
      ),
      errorBorder: InputBorder.none,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      isCollapsed: true,
    );

double getTextWidth(String s, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: s, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size.width;
}
