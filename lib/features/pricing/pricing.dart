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
import 'package:smart_chef_app/features/pricing/widgets/legend_switch_bar.dart';
import 'package:smart_chef_app/features/pricing/widgets/review.dart';

import 'widgets/pricing_plan.dart';

final isYearlyProvider = StateProvider<bool>((ref) {
  return false;
});

class PricingScreen extends LegendWidget {
  static String route = "/pricing";

  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final isMobile = SizeInfo.of(context).width < 880;
    final testemonialsCollapsed = SizeInfo.of(context).width < 1000;

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
                PricingPlan(
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
                    child: PricingPlan(
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
            ).toColumnIf(isMobile),
            // const SizedBox(height: 64),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     SizedBox(width: 300, child: Review()),
            //     SizedBox(
            //       height: 32,
            //       width: 32,
            //     ),
            //     SizedBox(width: 300, child: Review()),
            //     SizedBox(
            //       height: 32,
            //       width: 32,
            //     ),
            //     SizedBox(width: 300, child: Review()),
            //   ],
            // ).toColumnIf(testemonialsCollapsed),
          ],
        );
      },
    );
  }
}

// extension ListUtil on List<Widget> {
//   List<Widget> wrapWithExpanded({
//     List<int>? flex,
//   }) {
//     return [
//       for (var i = 0; i < length; i++)
//         Expanded(
//           flex: flex?.get(i) ?? 1,
//           child: this[i],
//         )
//     ];
//   }
// }

// extension ListIntUtil<T> on List<T> {
//   T? get(int index) {
//     try {
//       return this[index];
//     } catch (e) {
//       return null;
//     }
//   }
// }

// extension Utila on Widget {
//   Widget wrapIf(
//     bool condition,
//     Widget Function(Widget) builder, [
//     Widget Function(Widget)? elseBuilder,
//   ]) {
//     if (condition) {
//       return builder(this);
//     } else {
//       return elseBuilder?.call(this) ?? this;
//     }
//   }
// }
