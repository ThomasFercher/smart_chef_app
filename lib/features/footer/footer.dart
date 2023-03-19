import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return LegendRichText(
      text: [
        RichTextItem(
          style: theme.typography.h4.copyWith(
            color: theme.footerColors.foreground,
            fontWeight: FontWeight.w200,
          ),
          text: "Smart Chef",
        ),
        RichTextItem(
          style: theme.typography.h0
              .copyWith(color: theme.footerColors.foreground),
          text: "powered by OpenAI",
        ),
      ],
    );
  }
}
