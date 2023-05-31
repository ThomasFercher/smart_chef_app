import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/categories.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/ingredient_widget.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/selected_ingredient_widget.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';

class SelectIngredientsSection extends ConsumerWidget {
  const SelectIngredientsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIngredients = ref.watch(selectedIngredient);
    final theme = LegendTheme.of(context);
    final searchText = theme.typography.h1
        .copyWith(color: theme.colors.foreground4, fontSize: 16);
    return Container(
      width: SizeInfo.of(context).width,
      height: context.viewportHeight,
      padding: EdgeInsets.all(theme.sizing.spacing1),
      child: ElevatedCard(
        background: theme.colors.background2,
        padding: EdgeInsets.all(theme.sizing.spacing2),
        borderRadius: theme.sizing.radius1.asRadius(),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendText(
              "Select your Ingredients",
              style: theme.typography.h4,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    snap: true,
                    floating: true,
                    leading: const SizedBox(),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27.0),
                    ),
                    toolbarHeight: 200,
                    flexibleSpace: Stack(
                      children: [
                        Positioned(
                          bottom: 20,
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colors.background2,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CategoryWidget(),
                            const SizedBox(
                              height: 16,
                            ),
                            LegendInput(
                              height: 54,
                              expands: true,
                              style: searchText,
                              decoration: inputDecoration(
                                theme,
                                null,
                                hintText: "Search Ingredients",
                                textStyle: searchText,
                                fillColor: theme.colors.background2,
                              ),
                              onChanged: (value) => ref
                                  .read(searchTextProvider.notifier)
                                  .state = value,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const IngredientWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration inputDecoration(
  LegendTheme theme,
  String? errorMessage, {
  String? hintText,
  Color? fillColor,
  TextStyle? textStyle,
}) {
  final radius = 27.0.asRadius();
  return InputDecoration(
    fillColor: fillColor,
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 16, right: 12),
      child: Icon(
        Icons.search,
        color: theme.colors.foreground4,
        size: 26,
      ),
    ),
    filled: fillColor != null,
    hintText: hintText,
    hintStyle: textStyle ??
        theme.typography.h1.copyWith(
          color: theme.colors.foreground4,
        ),
    errorText: errorMessage,
    errorStyle: textStyle ??
        theme.typography.h0.copyWith(
          color: theme.colors.error,
        ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: theme.colors.error,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: theme.colors.foreground4,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: theme.colors.foreground4,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: theme.colors.selection,
        width: 2,
      ),
    ),
  );
}
