import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/add_tool_button.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/difficulty_card.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/widgets/selectable_chip.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';

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
                child: Consumer(builder: (context, ref, child) {
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
