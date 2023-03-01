import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:smart_chef_app/widgets/selectable_list.dart';

class CategoryWidget extends LegendWidget {
  final SplayTreeSet<dynamic> sorted;
  const CategoryWidget(this.sorted, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return SelectableList(
      children: [
        for (final category in sorted)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            color: theme.colors.background2,
            child: Center(
              child: LegendText(
                category,
                style: theme.typography.h1,
                fontSize: 18,
                color: theme.colors.foreground1,
              ),
            ),
          ),
      ],
    );
  }
}
