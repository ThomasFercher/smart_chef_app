import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/select_info_providers.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/add_tool_button.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/difficulty_card.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/selectable_chip.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SelectInfoSection extends HookConsumerWidget {
  const SelectInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    final servingAmountController = useTextEditingController(
      text: ref.read(servingAmountProvider).toString(),
    );
    final tools = ref.watch(toolsProvider);
    final selTools = ref.watch(selectedToolsProvider);
    final selDiff = ref.watch(difficultyProvider);
    final time = ref.watch(minuteProvider);
    final ingredientSelectMode = ref.watch(ingredientModeProvider);

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
                errorMessage: selTools.error,
                child: Column(
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
                            selected: selTools.value.contains(tool),
                            def: defaultTools.contains(tool),
                            onDelete: () {
                              ref.read(toolsProvider.notifier).update((state) {
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
                        AddToolButton(
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
                ),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "Difficulty",
                subtitle: "Select your cooking pedigree",
                errorMessage: selDiff.error,
                child: Container(
                  child: Row(
                    children: [
                      for (final difficulty in Difficulty.values)
                        DifficultyCard(
                          title: difficulty.label,
                          selected: selDiff.value == difficulty,
                          onTap: () {
                            final notifier =
                                ref.read(difficultyProvider.notifier);

                            if (notifier.value == difficulty) {
                              notifier.value = null;
                              return;
                            }
                            notifier.value = difficulty;
                          },
                        ).expandIf(!theme.isSmall),
                    ].withSpacing(24),
                  ).toColumnIf(
                    theme.isSmall,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "How much time do you have?",
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colors.background4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 24,
                            color: theme.colors.primary,
                          ),
                          const SizedBox(width: 12),
                          LegendText(
                            "${time.toInt()} minutes",
                            style: theme.typography.h2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SliderTheme(
                      data: const SliderThemeData(
                        trackHeight: 10,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 14,
                        ),
                      ),
                      child: Slider(
                        activeColor: theme.colors.primary,
                        value: time,
                        min: 5,
                        max: 180,
                        onChanged: (value) {
                          ref.read(minuteProvider.notifier).state =
                              value.ceilToDouble();
                        },
                        divisions: 35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "How many people are you cooking for?",
                child: LegendInput(
                  decoration: geLoginDecoration(theme, null),
                  keyboardType: TextInputType.number,
                  ctrl: servingAmountController,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    NumericTextFormatter(),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "Ingredient Mode",
                errorMessage: ingredientSelectMode.error,
                child: GridView.count(
                  crossAxisCount: theme.isSmall || theme.isMedium ? 1 : 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3,
                  children: [
                    for (final selectionMode in IngredientMode.values)
                      DifficultyCard(
                        description:
                            IngredientModeDescription.values.firstWhere(
                          (element) => element.index == selectionMode.index,
                        ),
                        title: selectionMode.label,
                        selected: ingredientSelectMode.value == selectionMode,
                        onTap: () {
                          final notifier =
                              ref.read(ingredientModeProvider.notifier);
                          if (notifier.value == selectionMode) {
                            notifier.value = null;
                            return;
                          }
                          notifier.value = selectionMode;
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
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
  final String? errorMessage;

  const _ConfigSection({
    Key? key,
    this.title,
    this.subtitle,
    required this.child,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    final showError = errorMessage != null;
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.sizing.radius1.asRadius(),
        color: theme.colors.background2,
        border: Border.all(
          color: theme.colors.error,
          width: 2,
        ).ifElseNull(showError),
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
          if (showError)
            LegendText(
              errorMessage,
              style: theme.typography.h2.copyWith(
                color: theme.colors.error,
              ),
              margin: const EdgeInsets.only(bottom: 12),
            ),
          child,
        ],
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

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    final pattern = RegExp(r"^(?:100|[1-9]\d?)$");
    if (pattern.hasMatch(text)) return newValue;
    return oldValue;
  }
}
