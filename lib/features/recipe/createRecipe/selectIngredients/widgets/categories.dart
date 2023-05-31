import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryWidget extends HookConsumerWidget {
  final double itemExtent = 120;
  final double itemSpacing = 16;

  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final isAtStart = useState(true);
    final isAtEnd = useState(false);
    final sorted = ref.watch(categoryDataProvider);
    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        isAtStart.value = controller.offset <= 0;
        isAtEnd.value =
            controller.offset >= controller.position.maxScrollExtent;
      });
    }, []);

    return LayoutBuilder(builder: (context, constraints) {
      return sorted.when(
        data: (sorted) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              physics: const ClampingScrollPhysics(),
              dragDevices: {
                PointerDeviceKind.trackpad,
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: SizedBox(
              height: 120,
              child: Stack(
                children: [
                  ListView.separated(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: itemSpacing),
                    itemBuilder: (context, index) {
                      final item = sorted[index];
                      return _CategoryItem(
                        categpry: item,
                        itemExtent: itemExtent,
                      );
                    },
                    itemCount: sorted.length,
                  ),
                  if (!isAtStart.value)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: LegendAnimatedIcon(
                          icon: Icons.arrow_back_ios_new,
                          theme: LegendAnimtedIconTheme(
                            enabled: theme.colors.selection,
                            disabled: theme.colors.foreground1,
                          ),
                          onPressed: () {
                            final offset = controller.offset;
                            final extent = itemExtent + itemSpacing;
                            final width = constraints.maxWidth;
                            final overflowLeft = width % extent;
                            final dx = width - overflowLeft;

                            controller.animateTo(
                              offset - dx,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          disableShadow: true,
                        ),
                      ),
                    ),
                  if (!isAtEnd.value)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: LegendAnimatedIcon(
                          icon: Icons.arrow_forward_ios,
                          theme: LegendAnimtedIconTheme(
                            enabled: theme.colors.selection,
                            disabled: theme.colors.foreground1,
                          ),
                          onPressed: () {
                            final offset = controller.offset;
                            final extent = itemExtent + itemSpacing;
                            final width = constraints.maxWidth;
                            final overflowLeft = width % extent;
                            final dx = width - overflowLeft;

                            controller.animateTo(
                              offset + dx,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          disableShadow: true,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  int getIndexByOffset(double offset) =>
      (offset / (itemExtent + itemSpacing)).floor();
}

class _CategoryItem extends ConsumerWidget {
  final String categpry;
  final double itemExtent;

  const _CategoryItem({
    super.key,
    required this.categpry,
    required this.itemExtent,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = LegendTheme.of(context);
    final isSelected = ref.watch(selectedCategoriesProvider).contains(categpry);

    ref.listen(selectedCategoriesProvider, (previous, next) {
      Logger.log('previous: $previous, next: $next');
    });
    final background =
        isSelected ? theme.colors.primary : theme.colors.background4;
    return LegendDetector(
      onTap: () {
        ref.read(selectedCategoriesProvider.notifier).update((state) {
          if (state.contains(categpry)) {
            state.remove(categpry);
            return [...state];
          }

          return [...state, categpry];
        });
      },
      background: background,
      borderRadius: BorderRadius.circular(12.0),
      child: SizedBox(
        width: itemExtent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/$categpry.png',
              fit: BoxFit.fill,
              height: 64,
              width: 64,
            ),
            const SizedBox(
              height: 8,
            ),
            LegendText(
              categpry,
              style: theme.typography.h1,
              fontWeight: FontWeight.bold,
              color: theme.colors.foreground5,
              textAlign: TextAlign.center,
              selectable: false,
            ),
          ],
        ),
      ),
    );
  }
}
