import 'dart:collection';
import 'dart:ui';
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
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: ClampingScrollPhysics(),
            dragDevices: {
              PointerDeviceKind.trackpad,
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 120,
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: theme.colors.background2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                ref.read(categoryProvider.notifier).state =
                                    sorted[index].title;
                              },
                              child: Image.asset(
                                'assets/images/${sorted[index].title}.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          LegendText(
                            sorted[index].title,
                            style: theme.typography.h1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colors.foreground1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: sorted.length),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
