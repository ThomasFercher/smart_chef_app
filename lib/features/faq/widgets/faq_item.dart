import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/input/expandable/legend_expandable..dart';

class FAQItem extends LegendWidget {
  final String title;
  final String description;

  const FAQItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return LegendExpandable(
      titlePadding: EdgeInsets.zero,
      title: LegendText(
        title,
        style: theme.typography.h3,
      ),
      children: [
        const SizedBox(height: 8),
        LegendText(
          description,
          style: theme.typography.h1,
        ),
      ],
    );
  }
}
