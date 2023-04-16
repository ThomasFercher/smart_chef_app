import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/rich/legend_rich_text.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/animated_card.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/pricing/pricing.dart';

class PricingPlan extends LegendWidget {
  final Color background;
  final Color foreground;
  final String title;
  final String subtitle;
  final double price;
  final List<String> features;

  const PricingPlan({
    super.key,
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
