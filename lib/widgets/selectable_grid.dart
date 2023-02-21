import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_widgets/input/text/legendInputDecoration.dart';
import 'package:legend_design_widgets/input/text/legendTextField.dart';
import 'package:smart_chef_app/widgets/category_widget.dart';
import 'package:smart_chef_app/widgets/grid_item.dart';

class SelectableGrid extends ConsumerWidget {
  final List<Widget> children;

  const SelectableGrid({super.key, required this.children});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const CategoryWidget(),
        LegendTextField(decoration: LegendInputDecoration.rounded()),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: children.length,
            itemBuilder: (context, index) {
              return GridItem(
                child: children[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
