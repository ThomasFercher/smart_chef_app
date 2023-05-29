import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:smart_chef_app/providers/ingredient_provider.dart';

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
            physics: const ClampingScrollPhysics(),
            dragDevices: {
              PointerDeviceKind.trackpad,
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 120,
                  child: ElevatedBox(
                    elevation: 2.0,
                    decoration: BoxDecoration(
                      color: theme.colors.background4,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
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
                            color: theme.colors.foreground5,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: sorted.length,
            ),
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
