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
              bottom: Radius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LegendText(
                  "Introducing Smartchef",
                  style: theme.typography.h5,
                  textAlign: TextAlign.center,
                ),
                spacer,
                LegendText(
                  "Your Ultimate AI-Powered Cooking Companion",
                  style: theme.typography.h4,
                  color: theme.colors.foreground2,
                  textAlign: TextAlign.center,
                ),
                spacer2,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: const LegendText(
                    "Welcome to Smartchef, the ultimate AI-powered cooking assistant designed to make your culinary journey seamless and enjoyable. Whether you're a cooking novice or a seasoned chef, our platform offers a range of innovative features that cater to all your kitchen needs. From generating personalized recipes and meal plans to answering your cooking queries, Smartchef is here to help you save time, reduce stress, and elevate your home dining experience. Embrace the future of cooking with Smartchef – your one-stop destination for all things culinary.",
                    textAlign: TextAlign.center,
                  ),
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
            padding: const EdgeInsets.all(32),
            title: LegendText("Recipe Generation", style: theme.typography.h3),
            titleAligment: Alignment.center,
            child: Column(
              children: const [
                LegendText(
                  "Are you tired of cooking the same old dishes? With Smartchef's AI-powered Recipe Generator, you can instantly create unique and delicious recipes tailored to your tastes and preferences. Just enter the ingredients you have on hand or select a specific cuisine, and let our AI work its magic! Explore a world of gastronomic delights and surprise yourself with new, mouth-watering dishes every day.",
                )
              ],
            ),
          ),
          LegendSection(
            padding: const EdgeInsets.all(32),
            title: LegendText("Meal Planner", style: theme.typography.h3),
            titleAligment: Alignment.center,
            child: const LegendText(
              "Struggling to plan your meals for the week? Say goodbye to last-minute grocery runs and food-related stress! Smartchef's AI-powered Mealplan Generator is here to make your life easier. Based on your dietary preferences, allergies, and time constraints, our AI will craft a comprehensive meal plan tailored to your needs. Save time, eat healthily, and enjoy a variety of delicious meals throughout the week.",
            ),
          ),
          LegendSection(
            padding: const EdgeInsets.all(32),
            title: LegendText("Assistant", style: theme.typography.h3),
            titleAligment: Alignment.center,
            child: const LegendText(
              "Have a cooking question? Need advice on ingredient substitutions or cooking techniques? Smartchef's AI-powered Cooking Assistant is here",
            ),
          ),
        ];
      },
    );
  }
}
