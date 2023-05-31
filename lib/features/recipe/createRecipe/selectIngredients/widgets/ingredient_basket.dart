import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/selected_ingredient_widget.dart';

const _kDuration = Duration(milliseconds: 300);
const _kCurve = Curves.easeInOut;

class IngredientBasket extends ConsumerWidget {
  final isExpanded = ValueNotifier<bool>(false);

  IngredientBasket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, expanded, _) {
        final widget = switch (expanded) {
          true => Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LegendText(
                        'Ingredients',
                        color: theme.colors.foreground1,
                        style: theme.typography.h4,
                        fontWeight: FontWeight.bold,
                      ),
                      LegendAnimatedIcon(
                        icon: Icons.close,
                        theme: LegendAnimtedIconTheme(
                            enabled: theme.colors.selection,
                            disabled: theme.colors.foreground1),
                        onPressed: () {
                          isExpanded.value = !expanded;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Expanded(child: SelectedIngredients()),
                ],
              ),
            ),
          false => LegendDetector(
              onTap: () {
                isExpanded.value = !expanded;
              },
              borderRadius: 1E9.asRadius(),
              child: Icon(
                Icons.shopping_basket,
                color: theme.colors.foreground1,
              ),
            ),
        };

        return AnimatedAlign(
          duration: _kDuration,
          curve: _kCurve,
          alignment: switch (expanded) {
            false => Alignment.bottomLeft,
            true => Alignment.center,
          },
          child: AnimatedContainer(
            duration: _kDuration,
            curve: _kCurve,
            margin: EdgeInsets.only(
              left: theme.sizing.spacing1,
              bottom: theme.sizing.spacing1,
            ).ifElseNull(!expanded),
            decoration: BoxDecoration(
              borderRadius: switch (expanded) {
                false => BorderRadius.circular(40.0),
                true => BorderRadius.circular(16.0),
              },
              color: switch (expanded) {
                false => theme.colors.primary,
                true => theme.colors.background3,
              },
              boxShadow: [
                BoxShadow(
                  color: theme.colors.foreground1.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            height: switch (expanded) {
              false => 80,
              true => 800,
            },
            width: switch (expanded) {
              false => 80,
              true => 400,
            },
            child: widget,
          ),
        );
      },
    );
  }
}
