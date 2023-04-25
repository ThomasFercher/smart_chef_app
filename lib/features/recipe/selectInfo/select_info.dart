import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';

class SelectInfoSection extends LegendWidget {
  const SelectInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LegendText(
          "Welcome to the Smart Chef Recipe Generator",
          style: theme.typography.h5,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.amber,
            ),
          ),
        )
      ],
    );
  }
}
