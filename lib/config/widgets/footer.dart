import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return Center(
      child: LegendText(
        "Legend Design",
        style: theme.typography.h4.copyWith(
          color: theme.footerColors.foreground,
        ),
      ),
    );
  }
}
