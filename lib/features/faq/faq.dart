import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/faq/widgets/faq_item.dart';

class FAQScreen extends LegendWidget {
  static String route = "/faq";

  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context, theme) {
    return LegendRouteBody(
      disableContentDecoration: true,
      builder: (context, s) {
        return Column(
          children: [
            const SizedBox(height: 64),
            LegendText(
              "FAQ",
              style: theme.typography.h5,
              fontSize: 64,
            ),
            const SizedBox(height: 20),
            LegendText(
              "Frequently Asked Questions",
              style: theme.typography.h2,
            ),
            const SizedBox(height: 64),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              margin: const EdgeInsets.all(32),
              child: Column(
                children: const [
                  FAQItem(
                    title: "What is Smart Chef?",
                    description:
                        "Smart Chef is a meal planning app that helps you plan your meals and grocery list.",
                  ),
                  FAQItem(
                    title: "How can you generate a Recipe?",
                    description:
                        "Smart Chef is a meal planning app that helps you plan your meals and grocery list.",
                  ),
                  FAQItem(
                    title: "How can you create a mealplan",
                    description:
                        "Smart Chef is a meal planning app that helps you plan your meals and grocery list.",
                  ),
                  FAQItem(
                    title: "How many recipes can I create?",
                    description:
                        "Smart Chef is a meal planning app that helps you plan your meals and grocery list.",
                  ),
                ].spacingInsideColumn(24),
              ),
            ),
          ],
        );
      },
    );
  }
}
