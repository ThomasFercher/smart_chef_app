import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/section/legend_section.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_widgets/datadisplay/card/legend_card.dart';
import 'package:legend_design_widgets/datadisplay/carousel/legend_carousel.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/legend_utils.dart';

class HomePage extends LegendWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    const spacer = SizedBox(height: 16);
    const spacer2 = SizedBox(height: 32);
    return LegendRouteBody(
      children: (controller, s) {
        return [
          LegendSection(
            color: theme.colors.background2,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(48),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spacer2,
                LegendText(
                  "Discover AI-Generated Recipes",
                  style: theme.typography.h5,
                ),
                spacer,
                LegendText(
                  "Tailored just for you",
                  style: theme.typography.h4,
                  color: theme.colors.foreground2,
                ),
                spacer2,
                const LegendText(
                  "Find new and personalized recipes based on your preferences and dietary needs",
                ),
                spacer2,
                LegendButton(
                  borderRadius: 32.0.asRadius(),
                  height: 64,
                  width: 240,
                  selBackground: theme.colors.secondary,
                  selElevation: 1,
                  background: theme.colors.primary,
                  onTap: () {
                    LegendRouter.of(context).pushPage('/recipe');
                  },
                  text: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LegendText(
                        "Get Started",
                        style: theme.typography.h2,
                        color: theme.colors.onPrimary,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: theme.colors.onPrimary,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                spacer2,
                spacer2,
              ],
            ),
          ),
          const LegendSection(
            child: LegendCarousel(
              height: 420,
              items: [
                Center(child: LegendText("Exmaple 1")),
                Center(child: LegendText("Exmaple 2")),
                Center(child: LegendText("Exmaple 3")),
              ],
            ),
          ),
          LegendSection(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(48),
            ),
            padding: EdgeInsets.all(32),
            title: LegendText("Recipe Generator", style: theme.typography.h3),
            titleAligment: Alignment.center,
            color: theme.colors.background2,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedCard(
                    height: 240,
                    elevation: 1,
                    background: theme.colors.background1,
                    borderRadius: 16.0.asRadius(),
                    margin: EdgeInsets.all(4),
                    child: Column(
                      children: [
                        LegendText("Ingredients"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedCard(
                    height: 240,
                    elevation: 1,
                    background: theme.colors.background1,
                    borderRadius: 16.0.asRadius(),
                    margin: EdgeInsets.all(4),
                    child: Column(
                      children: [
                        LegendText("Difficulty"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedCard(
                    height: 240,
                    elevation: 1,
                    background: theme.colors.background1,
                    borderRadius: 16.0.asRadius(),
                    margin: EdgeInsets.all(4),
                    child: Column(
                      children: [
                        LegendText("Stats"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
