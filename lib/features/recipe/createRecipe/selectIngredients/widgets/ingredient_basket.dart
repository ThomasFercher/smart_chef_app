import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/widgets/selected_ingredient_widget.dart';

const _kDuration = Duration(milliseconds: 300);
const _kCurve = Curves.easeInOut;

final isBasketExpandedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class IngredientBasket extends ConsumerWidget {
  const IngredientBasket({Key? key}) : super(key: key);

  Widget _widget(BuildContext context, bool expanded, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    if (expanded) {
      return Container(
        width: context.width,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(32.0),
          ),
          color: theme.colors.background2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LegendText(
                  'Selected Ingredients',
                  color: theme.colors.foreground1,
                  style: theme.typography.h4,
                  fontWeight: FontWeight.bold,
                ),
                LegendAnimatedIcon(
                  icon: Icons.close,
                  disableShadow: true,
                  theme: LegendAnimtedIconTheme(
                      enabled: theme.colors.selection,
                      disabled: theme.colors.foreground1),
                  onPressed: () {
                    ref
                        .read(isBasketExpandedProvider.notifier)
                        .update((state) => !state);
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            const SelectedIngredients(),
            const SizedBox(height: 16),
            Divider(
              color: theme.colors.foreground1.withOpacity(0.2),
              thickness: 1,
            ),
            const SizedBox(height: 64),
          ],
        ),
      );
    }
    final selectedIngredients = ref.watch(selectedIngredientProvider);
    final itemCount = selectedIngredients.length;
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Container(
        height: 64,
        width: 256,
        decoration: BoxDecoration(
          color: theme.colors.primary,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: theme.colors.foreground1.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: LegendDetector(
          onTap: () {
            ref
                .read(isBasketExpandedProvider.notifier)
                .update((state) => !state);
          },
          borderRadius: 1E9.asRadius(),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.shopping_basket,
                  color: theme.colors.foreground1,
                  size: 32,
                ),
              ),
              if (itemCount > 0)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 42,
                      bottom: 28,
                    ),
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 4,
                      top: 4,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colors.foreground1,
                      shape: BoxShape.circle,
                    ),
                    child: LegendText(
                      "$itemCount",
                      color: theme.colors.primary,
                      fontSize: 12,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final isExpanded = ref.watch(isBasketExpandedProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: _kDuration,
        curve: _kCurve,
        child: _widget(context, isExpanded, ref),
      ),
    );
  }
}
