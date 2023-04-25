import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/recipe/output/widgets/recipe_card.dart';
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OutputSection extends ConsumerWidget {
  const OutputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final isMobile = SizeInfo.of(context).width < 880;
    final recipeState = ref.watch(recipeProvider);
    return recipeState.when(
      data: (recipe) {
        return SizedBox(
          width: SizeInfo.of(context).width,
          height: SizeInfo.of(context).height,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                physics: const ClampingScrollPhysics(),
                dragDevices: {
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: LayoutBuilder(
                builder: (p0, p1) => ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: p1.maxHeight - 300,
                    minWidth: p1.maxWidth,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      LegendText(
                        recipe.name,
                        style: theme.typography.h4,
                      ),
                      Card(
                        elevation: 2.0,
                        color: theme.colors.background1,
                        shape: RoundedRectangleBorder(
                          borderRadius: theme.sizing.radius1.asRadius(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LegendText("Ingredients",
                                  style: theme.typography.h3),
                              SizedBox(
                                height: theme.sizing.spacing1,
                              ),
                              DynamicRow(
                                children: [
                                  for (final ingredient in recipe.ingredients)
                                    IngredientCard(
                                      child: LegendText(
                                        "${ingredient.name} - ${ingredient.amount}",
                                        style: theme.typography.h2,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: theme.sizing.spacing3,
                              ),
                              LegendText("Tools", style: theme.typography.h3),
                              SizedBox(
                                height: theme.sizing.spacing1,
                              ),
                              DynamicRow(
                                children: [
                                  for (final tool in recipe.tools)
                                    IngredientCard(
                                      child: LegendText(tool.toString(),
                                          style: theme.typography.h2),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: theme.sizing.spacing3,
                              ),
                              LegendText("Steps", style: theme.typography.h3),
                              SizedBox(
                                height: theme.sizing.spacing1,
                              ),
                              for (final step in recipe.steps)
                                LegendText(step.toString(),
                                    style: theme.typography.h2),
                              SizedBox(
                                height: theme.sizing.spacing3,
                              ),
                              LegendText("Tips", style: theme.typography.h3),
                              SizedBox(
                                height: theme.sizing.spacing1,
                              ),
                              for (final tip in recipe.tips)
                                LegendText(tip.toString(),
                                    style: theme.typography.h2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stack) {
        return Center(
          child: LegendText(
            error.toString(),
          ),
        );
      },
    );
  }
}
