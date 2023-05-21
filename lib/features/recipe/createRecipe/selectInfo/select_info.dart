import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_checkbox.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Difficulty {
  easy("Beginner"),
  medium("Intermediate"),
  hard("Advanced");

  final String label;

  const Difficulty(this.label);
}

enum IngredientSelection { all, some, none }

final difficultyProvider = StateProvider<Difficulty?>((ref) => null);
final ingredientSelectionProvider =
    StateProvider<IngredientSelection?>((ref) => null);

const defaultTools = ["Stove", "Airfryer", "Microwave", "Pan", "Pot", "Bowl"];

final toolsProvider = StateProvider<List<String>>((ref) => defaultTools);
final selectedToolsProvider = StateProvider<List<String>>((ref) => []);

class SelectInfoSection extends StatelessWidget {
  const SelectInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);

    return SizedBox(
      height: context.viewportHeight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              LegendText("Configure your Recipe", style: theme.typography.h5),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "Kitchen Tools",
                subtitle:
                    "Select the tools you have available. You can add your own tools by typing them in the input field below.",
                child: Consumer(builder: (context, ref, child) {
                  final selTools = ref.watch(selectedToolsProvider);
                  final tools = ref.watch(toolsProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      DynamicRow(
                        hSpacing: 12,
                        vSpacing: 12,
                        children: [
                          for (var tool in tools)
                            SelectableChip(
                              title: tool,
                              selected: selTools.contains(tool),
                              def: defaultTools.contains(tool),
                              onDelete: () {
                                ref
                                    .read(toolsProvider.notifier)
                                    .update((state) {
                                  state.remove(tool);
                                  return [...state];
                                });
                              },
                              onSelected: (v) {
                                ref
                                    .read(selectedToolsProvider.notifier)
                                    .update((state) {
                                  if (state.contains(tool)) {
                                    state.remove(tool);
                                    return [...state];
                                  }
                                  return [...state, tool];
                                });
                              },
                            ),
                          _AddToolButton(
                            onAdd: (name) {
                              ref.read(toolsProvider.notifier).update((state) {
                                if (state.contains(name)) return state;
                                return [...state, name];
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "Difficulty",
                subtitle: "Select your cooking pedigree",
                child: Consumer(builder: (context, ref, child) {
                  final selDiff = ref.watch(difficultyProvider);
                  return Container(
                    child: Row(
                      children: [
                        for (final difficulty in Difficulty.values)
                          _DifficultyCard(
                            title: difficulty.label,
                            selected: selDiff == difficulty,
                            onTap: () {
                              final notifier =
                                  ref.read(difficultyProvider.notifier);
                              if (notifier.state == difficulty) {
                                notifier.state = null;
                                return;
                              }
                              notifier.state = difficulty;
                            },
                          ).expandIf(!theme.isSmall),
                      ].withSpacing(24),
                    ).toColumnIf(
                      theme.isSmall,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "Ingredient Selection",
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfigSection extends LegendWidget {
  final String? title;
  final String? subtitle;
  final Widget child;

  const _ConfigSection({
    Key? key,
    this.title,
    this.subtitle,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.sizing.radius1.asRadius(),
        color: theme.colors.background2,
      ),
      padding: EdgeInsets.all(theme.sizing.spacing2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            LegendText(
              title,
              style: theme.typography.h3,
              margin: const EdgeInsets.only(bottom: 16),
            ),
          if (subtitle != null)
            LegendText(
              subtitle,
              style: theme.typography.h1,
              margin: const EdgeInsets.only(bottom: 12),
            ),
          child,
        ],
      ),
    );
  }
}

class _DifficultyCard extends LegendWidget {
  final String title;
  final bool selected;
  final void Function()? onTap;

  const _DifficultyCard({
    Key? key,
    required this.title,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return ElevatedCard(
      onTap: onTap,
      elevation: 1,
      background: theme.colors.background3,
      borderRadius: theme.sizing.radius1.asRadius(),
      child: Container(
        height: 120,
        //  width: 240,
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              left: 16,
              child: LegendText(
                title,
                style: theme.typography.h3,
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: LegendCheckboxNoState(
                value: selected,
                onChanged: (value) {
                  onTap?.call();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension Spacing on List<Widget> {
  List<Widget> withSpacing(double spacing) {
    return List.generate(length * 2 - 1, (index) {
      if (index.isEven) {
        return this[index ~/ 2];
      }
      return SizedBox(width: spacing, height: spacing);
    });
  }
}

class SelectableChip extends StatefulWidget {
  final String title;
  final bool selected;
  final bool def;

  final void Function(bool v)? onSelected;
  final void Function()? onDelete;

  const SelectableChip({
    Key? key,
    this.selected = false,
    this.onSelected,
    required this.title,
    this.onDelete,
    this.def = true,
  }) : super(key: key);

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  late bool visible;

  late bool showDelete;

  @override
  void initState() {
    showDelete = false;
    visible = widget.def;
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        visible = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);

    final color = showDelete
        ? theme.colors.error
        : widget.selected
            ? theme.colors.primary
            : theme.colors.background3;

    final height = theme.rVal<double>(s: 42, m: 48, l: 56, xl: 56);

    return GestureDetector(
      onTap: () {
        if (showDelete && !widget.def) {
          setState(() {
            showDelete = false;
          });
          return;
        }
        widget.onSelected?.call(!widget.selected);
      },
      onLongPress: () {
        if (widget.def) return;
        setState(() {
          showDelete = !showDelete;
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            padding: EdgeInsets.symmetric(
              horizontal: visible ? 42 : 8,
            ),
            height: height,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color,
            ),
            child: Column(
              // Workaround since using aligment Center fucks up the Dynamic Row
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: visible ? 1 : 0,
                  child: !showDelete
                      ? LegendText(
                          widget.title,
                          style: theme.typography.h2,
                          selectable: false,
                        )
                      : LegendAnimatedIcon(
                          icon: Icons.delete,
                          padding: const EdgeInsets.all(4),
                          iconSize: 24,
                          theme: LegendAnimtedIconTheme(
                              enabled: theme.colors.error.lighten(0.25),
                              disabled: theme.colors.error.lighten(0.25)),
                          onPressed: () {
                            widget.onDelete?.call();
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final isAddingProvider = StateProvider<bool>((ref) => false);

class _AddToolButton extends HookConsumerWidget {
  final void Function(String name) onAdd;

  const _AddToolButton({
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
