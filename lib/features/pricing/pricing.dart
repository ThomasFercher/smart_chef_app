import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';

import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/animated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/pricing/legend_switch_bar.dart';

final isYearlyProvider = StateProvider<bool>((ref) {
  return false;
});

class PricingScreen extends LegendWidget {
  static String route = "/pricing";

  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final isMobile = SizeInfo.of(context).width < 880;

    return LegendRouteBody(
      maxContentWidth: 800,
      builder: (context, s) {
        return Column(
          children: [
            const SizedBox(height: 64),
            LegendText(
              "Pricing Plans",
              style: theme.typography.h5,
              fontSize: 64,
            ),
            const SizedBox(height: 20),
            LegendText(
              "We offer a variety of plans to fit your needs.",
              style: theme.typography.h2,
            ),
            const SizedBox(height: 32),
            Consumer(builder: (context, ref, child) {
              return LegendSwitchBar(
                items: const ["Monthly", "Yearly"],
                onSelected: (index) {
                  ref.read(isYearlyProvider.notifier).state = index == 1;
                },
                selected: theme.colors.background1,
                selectedStyle: theme.typography.h1.copyWith(
                  color: theme.colors.selection,
                ),
                textStyle: theme.typography.h1.copyWith(
                  color: theme.colors.disabled,
                ),
                height: 56,
                padding: const EdgeInsets.all(6),
                itemWidth: 128,
              );
            }),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PricingPlan(
                  background: theme.colors.background1,
                  foreground: theme.colors.foreground1,
                  title: "Basic",
                  price: 0,
                  subtitle: "",
                  features: const [
                    "Up to 10 Recipes per month",
                    "Simple Nutrients",
                  ],
                ),
                const SizedBox(
                  width: 32,
                  height: 32,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black12,
                          Colors.black87,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.darken,
                    child: _PricingPlan(
                      background: theme.colors.primary,
                      foreground: theme.colors.onPrimary,
                      title: "Pro",
                      price: 5,
                      subtitle: "For the advanced chef",
                      features: const [
                        "Unlimited Recipes",
                        "Advanced Nutrients",
                        "Meal Planning",
                        "Cooking Assistant",
                      ],
                    ),
                  ),
                ),
              ],
            ).toColumnIf(isMobile)
          ],
        );
      },
    );
  }
}

class _PricingPlan extends LegendWidget {
  final Color background;
  final Color foreground;
  final String title;
  final String subtitle;
  final double price;
  final List<String> features;

  const _PricingPlan({
    required this.background,
    required this.foreground,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return AnimatedCard(
      width: 400,
      background: background,
      elevation: 0.25,
      selElevation: 1,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendText(
              title,
              style: theme.typography.h3,
              color: foreground,
            ),
            const SizedBox(height: 12),
            LegendText(
              subtitle,
              style: theme.typography.h0,
              fontSize: 16,
              color: foreground,
            ),
            const SizedBox(height: 16),
            Consumer(builder: (context, ref, child) {
              final isYearly = ref.watch(isYearlyProvider);
              final _price = isYearly ? price * 12 - price : price;
              final _label = isYearly ? "Year" : "Month";
              return LegendRichText(
                text: [
                  RichTextItem(
                    style: theme.typography.h5.copyWith(color: foreground),
                    text: "\$${_price.toStringAsFixed(2)}",
                  ),
                  RichTextItem(
                    style: theme.typography.h1.copyWith(color: foreground),
                    text: "/Per $_label",
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Column(
              children: [
                for (final feature in features)
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: foreground,
                      ),
                      const SizedBox(width: 16),
                      LegendText(
                        feature,
                        style: theme.typography.h1,
                        color: foreground,
                      ),
                    ],
                  ),
              ].spacingInsideColumn(12),
            ),
            if (price > 0) ...[
              const SizedBox(height: 32),
              LegendButton(
                background: foreground,
                borderRadius: BorderRadius.circular(1E9),
                height: 48,
                text: LegendText(
                  "Get Started",
                  style: theme.typography.h1,
                  color: background,
                  selectable: false,
                ),
                onTap: () {
                  print("Get Started");
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
