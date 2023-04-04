import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    final foreground = theme.footerColors.foreground;
    final header = theme.typography.h3.copyWith(color: foreground);
    final body = theme.typography.h1.copyWith(color: foreground);

    const spacer = SizedBox(height: 12);
    const spacer2 = SizedBox(height: 24);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                height: 96,
                color: foreground,
              ),
              LegendText(
                "Powered by OpenAI",
                style: theme.typography.h2,
                color: foreground,
                margin: EdgeInsets.only(left: 12),
              ),
              spacer,
              LegendText(
                "© Copyright 2023 Smartchef.\nAll rights reserved.",
                style: theme.typography.h0,
                color: foreground,
                margin: EdgeInsets.only(left: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LegendText("About", style: header),
              spacer2,
              LegendText("Contact", style: body),
              spacer,
              LegendText("Blog", style: body),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LegendText("Product", style: header),
              spacer2,
              LegendText("Pricing", style: body),
              spacer,
              LegendText("FAQ", style: body),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LegendText("Socials", style: header),
              spacer2,
              LegendText("Twitter", style: body),
              spacer,
              LegendText("Instagram", style: body),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LegendText("Legal", style: header),
              spacer2,
              LegendText("Terms of Service", style: body),
              spacer,
              LegendText("Privacy Policy", style: body),
            ],
          )
        ],
      ),
    );
  }
}
