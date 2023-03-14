import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/widgets/category_item.dart';

class SelectableList extends ConsumerWidget {
  final List<Widget> children;

  const SelectableList({super.key, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ScrollConfiguration(
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
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CategoryItem(
                child: children[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
