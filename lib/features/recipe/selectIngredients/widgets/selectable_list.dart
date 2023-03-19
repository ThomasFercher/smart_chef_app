import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/widgets/category_item.dart';

class SelectableList extends ConsumerWidget {
  final List<Widget> children;

  const SelectableList({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CategoryItem(
              child: children[index],
            ),
          );
        },
      ),
    );
  }
}
