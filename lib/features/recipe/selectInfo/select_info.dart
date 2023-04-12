import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';

class SelectInfoSection extends LegendWidget {
  const SelectInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LegendText(
          "Create your own recipe",
          style: theme.typography.h5,
        ),
      ],
    );
  }
}
