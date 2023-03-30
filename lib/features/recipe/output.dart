import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';

class OutputSection extends ConsumerWidget {
  const OutputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final recipeState = ref.watch(recipeProvider);

    return recipeState.when(
      data: (recipe) {
        return Column(
          children: [
            LegendText(
              "Recipe",
            ),
            LegendText(
              recipe.name,
            ),
          ],
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
