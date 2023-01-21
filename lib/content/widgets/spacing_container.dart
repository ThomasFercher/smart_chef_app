import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';
import 'package:legend_utils/legend_utils.dart';

class SpacingContainer extends StatelessWidget {
  final double width;
  final String title;

  const SpacingContainer({
    Key? key,
    required this.width,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.sizing.radius1.asRadius(),
        color: theme.colors.background3,
      ),
      padding: EdgeInsets.only(left: theme.sizing.spacing1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LegendRichText(
            text: [
              RichTextItem(style: theme.typography.h1, text: title),
              RichTextItem(style: theme.typography.h0, text: "[${width}px]"),
            ],
          ),
          SizedBox(
            width: theme.sizing.spacing1,
          ),
          Container(
            height: 48,
            width: width,
            decoration: BoxDecoration(
              color: theme.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
