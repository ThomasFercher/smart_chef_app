import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/selectable_list.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final sorted = ref.watch(categoryDataProvider);
    return sorted.when(
      data: (sorted) {
        return SizedBox(
          height: SizeInfo.of(context).height * 0.1,
          child: SelectableList(
            children: [
              for (final category in sorted)
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          ref.read(categoryProvider.notifier).state =
                              category.title;
                        },
                        child: Image.asset(
                          'assets/images/${category.title}.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: LegendText(
                        category.title,
                        style: theme.typography.h1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme.colors.foreground1,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
