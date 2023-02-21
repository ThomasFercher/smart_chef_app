import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/widgets/selectable_list.dart';

import '../content/providers/ingredient_provider.dart';

class CategoryWidget extends ConsumerWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ingredientDataProvider);
    final Set<String> categories = {};
    data.when(
      data: (data) {
        for (final ingredient in data) {
          categories.add(ingredient.category!);
        }
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    final sorted = SplayTreeSet.from(categories);
    return SelectableList(
      children: [
        for (final category in sorted)
          SizedBox(
            width: 100,
            child: Card(
              elevation: 2,
              color: Colors.green,
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.fastfood),
                    Text(category),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
