import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:smart_chef_app/widgets/selectable_list.dart';

import '../content/providers/ingredient_provider.dart';

class CategoryWidget extends LegendWidget {
  final SplayTreeSet<dynamic> sorted;
  const CategoryWidget(this.sorted, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return SelectableList(
      children: [
        for (final category in sorted)
          SizedBox(
            width: 220,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
              color: theme.colors.foreground1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LegendText(
                    category,
                    style: theme.typography.h2,
                    color: theme.colors.background2,
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
