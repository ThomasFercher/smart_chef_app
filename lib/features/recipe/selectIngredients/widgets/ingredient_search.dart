import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:searchfield/searchfield.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/ingredient_widget.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';
import 'package:smart_chef_app/services/models/ingredient.dart';

class IngredientSearch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final data = ref.watch(ingredientDataProvider);
    return Container(
      child: data.when(
        data: (data) {
          return SearchField(
            suggestions: data
                .map(
                  (e) => SearchFieldListItem(
                    e.name!,
                    item: e,
                    child: IngredientTile(ingredient: e),
                  ),
                )
                .toList(),
            hint: "Search for ingredients",
            searchInputDecoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: theme.sizing.radius1.asRadius(),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: theme.sizing.radius1.asRadius(),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          );
        },
        error: (err, s) => Text(
          err.toString(),
        ),
        loading: () => const Center(
          child: Placeholder(),
        ),
      ),
    );
  }
}
