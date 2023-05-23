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
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/add_tool_button.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/difficulty_card.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/selectable_chip.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

bool validateSelectInfo(WidgetRef ref) {
  bool isValid = true;

  /// Tools
  final tools = ref.read(selectedToolsProvider);
  if (tools.isEmpty) {
    isValid = false;
  }

  /// Difficulty
  final difficulty = ref.read(difficultyProvider);
  if (difficulty == null) {
    isValid = false;
  }

  /// Time is always valid

  /// Serving Amount is always valid

  /// Ingredient Mode
  final ingredientMode = ref.read(ingredientSelectionProvider);
  if (ingredientMode == null) {
    isValid = false;
  }

  return isValid;
}

enum Difficulty {
  easy("Beginner"),
  medium("Intermediate"),
  hard("Advanced");

  final String label;

  const Difficulty(this.label);
}

enum IngredientMode {
  random("Random"),
  strict("Strict"),
  stricGen("Strict with Generated Ingredients"),
  selection("Selection");

  final String label;

  const IngredientMode(this.label);
}

final difficultyProvider = StateProvider<Difficulty?>((ref) => null);
final ingredientSelectionProvider =
    StateProvider<IngredientMode?>((ref) => null);

const defaultTools = ["Stove", "Airfryer", "Microwave", "Pan", "Pot", "Bowl"];

final toolsProvider = StateProvider<List<String>>((ref) => defaultTools);
final selectedToolsProvider = StateProvider<List<String>>((ref) => []);

final minuteProvider = StateProvider<double>((ref) => 60);

final servingAmountProvider = StateProvider<int?>((ref) => 1);

class SelectInfoSection extends HookConsumerWidget {
  const SelectInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    final servingAmountController = useTextEditingController(
        text: ref.read(servingAmountProvider).toString());

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
                  );
                }),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "Difficulty",
                subtitle: "Select your cooking pedigree",
                child: Consumer(
                  builder: (context, ref, child) {
                    final selDiff = ref.watch(difficultyProvider);
                    return Container(
                      child: Row(
                        children: [
                          for (final difficulty in Difficulty.values)
                            DifficultyCard(
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
                  },
                ),
              ),
              const SizedBox(height: 32),
              _ConfigSection(
                title: "How much time do you have?",
                child: Consumer(builder: (context, ref, child) {
                  final value = ref.watch(minuteProvider);
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.colors.background4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(16),
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
                              "${value.toInt()} minutes",
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
                          value: value,
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
                  );
                }),
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
                child: Consumer(
                  builder: (context, ref, child) {
                    final selectedMode = ref.watch(ingredientSelectionProvider);
                    return GridView.count(
                      crossAxisCount: theme.isSmall || theme.isMedium ? 1 : 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3,
                      children: [
                        for (final selectionMode in IngredientMode.values)
                          DifficultyCard(
                            title: selectionMode.label,
                            selected: selectedMode == selectionMode,
                            onTap: () {
                              final notifier = ref
                                  .read(ingredientSelectionProvider.notifier);
                              if (notifier.state == selectionMode) {
                                notifier.state = null;
                                return;
                              }
                              notifier.state = selectionMode;
                            },
                          ),
                      ],
                    );
                  },
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
