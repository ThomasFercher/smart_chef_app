import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/features/faq/faq.dart';
import 'package:smart_chef_app/features/pricing/pricing.dart';
import 'package:smart_chef_app/features/privacyPolicy/privacy_policy.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    final foreground = theme.footerColors.foreground;
    final header = theme.typography.h3.copyWith(color: foreground);
    final body = theme.typography.h1.copyWith(color: foreground);

    const spacer = SizedBox(height: 12, width: 12);
    const spacer2 = SizedBox(height: 16, width: 24);

    final isSmall = SizeInfo.of(context).width < 800;
    return Container(
      color: theme.footerColors.background,
      padding: EdgeInsets.all(theme.sizing.spacing3),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: theme.footerSizing.maxWidth),
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
                  margin: const EdgeInsets.only(left: 12).ifW(!isSmall),
                ),
                spacer,
                LegendText(
                  "© Copyright 2023 Smartchef.${isSmall ? " " : "\n"}All rights reserved.",
                  style: theme.typography.h0,
                  color: foreground,
                  margin: const EdgeInsets.only(left: 12).ifW(!isSmall),
                ),
              ],
            ),
            if (isSmall) const SizedBox(height: 48),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendText("About", style: header),
                if (isSmall) const Spacer(),
                spacer2,
                LegendText(
                  "Contact",
                  style: body,
                  selectable: false,
                  onTap: () => LegendFunctions.launchInBrowser(
                    "mailto:info@smartchef.ai",
                  ),
                ),
                spacer,
                LegendText(
                  "",
                  style: body,
                  selectable: false,
                ),
              ],
            ).toRowIf(isSmall, crossAxisAlignment: CrossAxisAlignment.end),
            if (isSmall) spacer,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendText("Product", style: header),
                if (isSmall) const Spacer(),
                spacer2,
                LegendText(
                  "Pricing",
                  style: body,
                  selectable: false,
                  onTap: () => LegendRouter.of(context).pushPage(
                    PricingScreen.route,
                  ),
                ),
                spacer,
                LegendText(
                  "FAQ",
                  style: body,
                  selectable: false,
                  onTap: () => LegendRouter.of(context).pushPage(
                    FAQScreen.route,
                  ),
                ),
              ],
            ).toRowIf(isSmall, crossAxisAlignment: CrossAxisAlignment.end),
            if (isSmall) spacer,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendText("Socials", style: header),
                if (isSmall) const Spacer(),
                spacer2,
                LegendText(
                  "Twitter",
                  style: body,
                  selectable: false,
                  onTap: () => LegendFunctions.launchInBrowser(
                    "https://twitter.com/SmartChefAI",
                  ),
                ),
                spacer,
                LegendText(
                  "Instagram",
                  style: body,
                  selectable: false,
                  onTap: () => LegendFunctions.launchInBrowser(
                    "https://www.instagram.com/smartchefai/",
                  ),
                ),
              ],
            ).toRowIf(isSmall, crossAxisAlignment: CrossAxisAlignment.end),
            if (isSmall) spacer,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendText("Legal", style: header),
                if (isSmall) const Spacer(),
                spacer2,
                LegendText(
                  "Terms of Service",
                  style: body,
                  selectable: false,
                  onTap: () => LegendRouter.of(context).pushPage(
                    PrivacyPolicyPage.route,
                  ),
                ),
                spacer,
                LegendText(
                  "Privacy Policy",
                  style: body,
                  selectable: false,
                  onTap: () => LegendRouter.of(context).pushPage(
                    PrivacyPolicyPage.route,
                  ),
                ),
              ],
            ).toRowIf(isSmall, crossAxisAlignment: CrossAxisAlignment.end),
          ],
        ).toColumnIf(
          SizeInfo.of(context).width < 800,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}

extension DynamicFlexLayout on Flex {
  Flex toRowIf(
    bool condition, {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    if (condition) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }
    return this;
  }

  Flex toColumnIf(
    bool condition, {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    if (condition) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }
    return this;
  }
}

extension widgetIf<T> on T {
  T? ifW(bool condition) {
    if (condition) return this;
    return null;
  }

  T ifElse(bool condition, T elseValue) {
    if (condition) return this;
    return elseValue;
  }
}
