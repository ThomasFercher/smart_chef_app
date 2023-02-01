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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            child: children[index],
          );
        },
      ),
    );
  }
}
