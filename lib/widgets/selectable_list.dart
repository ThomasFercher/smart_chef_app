import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/services/model/category.dart';
import 'package:smart_chef_app/services/model/ingredient.dart';
import 'package:smart_chef_app/widgets/category_item.dart';

import '../providers/ingredient_provider.dart';

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
        dragDevices: {
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
