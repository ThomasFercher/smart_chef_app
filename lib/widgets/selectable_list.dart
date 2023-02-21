import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/widgets/category_item.dart';

class SelectableList extends ConsumerWidget {
  final List<Widget> children;

  const SelectableList({super.key, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 150,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.horizontal,
          itemCount: children.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
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
