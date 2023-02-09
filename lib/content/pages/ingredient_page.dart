import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/content/providers/ingredient_provider.dart';

class IngredientPage extends ConsumerWidget {
  const IngredientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ingredientDataProvider);
    return Scaffold(
      body: data.when(
        data: (data) {
          return Column(
            children: [
              ...data.map(
                (e) => ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Column(
                        children: [
                          Text(e.name),
                          Text(e.category),
                          Text(e.unit),
                          Text(e.calories.toString()),
                          Text(e.joules.toString()),
                          Text(e.fat.toString()),
                          Text(e.protein.toString()),
                          Text(e.carbohydrates.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
