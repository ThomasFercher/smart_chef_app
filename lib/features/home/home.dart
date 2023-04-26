import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legend_design_core/layout/navigation/section/legend_section.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/theme_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/datadisplay/carousel/legend_carousel.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/footer/footer.dart';

class HomePage extends LegendWidget {
  static String route = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    const spacer = SizedBox(height: 16);
    const spacer2 = SizedBox(height: 32);
    const spacer3 = SizedBox(height: 96);
    const spacerH = SizedBox(width: 64);

    return LegendRouteBody(
      maxContentWidth: 1440,
      children: (controller, s) {
        return [
          LegendSection(
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
          spacer3,
          _InfoSection(
            image: "assets/illustrations/i13.png",
            content: [
              LegendText(
                "Recipe Generation",
                style: theme.typography.h3,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 16,
              ),
              const LegendText(
                "Are you tired of cooking the same old dishes? With Smartchef's AI-powered Recipe Generator, you can instantly create unique and delicious recipes tailored to your tastes and preferences. Just enter the ingredients you have on hand or select a specific cuisine, and let our AI work its magic! Explore a world of gastronomic delights and surprise yourself with new, mouth-watering dishes every day.",
                textAlign: TextAlign.left,
              ),
            ],
          ),
          spacer3,
          _InfoSection(
            image: "assets/illustrations/i05.png",
            content: [
              LegendText("Meal Planner", style: theme.typography.h3),
              const SizedBox(
                height: 16,
              ),
              LegendText(
                "Struggling to plan your meals for the week? Say goodbye to last-minute grocery runs and food-related stress! Smartchef's AI-powered Mealplan Generator is here to make your life easier. Based on your dietary preferences, allergies, and time constraints, our AI will craft a comprehensive meal plan tailored to your needs. Save time, eat healthily, and enjoy a variety of delicious meals throughout the week.",
                style: theme.typography.h1,
              ),
            ],
          ),
          spacer3,
          _InfoSection(
            image: "assets/illustrations/i08.png",
            content: [
              LegendText(
                "Personal AI Assistant",
                style: theme.typography.h3,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 16,
              ),
              LegendText(
                "Have a cooking question? Need advice on ingredient substitutions or cooking techniques? Smartchef's AI-powered Cooking Assistant is here",
                textAlign: TextAlign.left,
                style: theme.typography.h1,
              ),
            ],
          ),
          spacer3,
        ];
      },
    );
  }
}

class _InfoSection extends LegendWidget {
  final String image;
  final List<Widget> content;

  const _InfoSection({
    Key? key,
    required this.image,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    final imgRadius = theme.rVal<double>(s: 24, m: 24, l: 64, xl: 64);
    final sectionHeight =
        theme.rVal<double?>(s: null, m: null, l: 420, xl: 512);
    final collapsed = theme.rVal(s: true, m: true, l: false, xl: false);
    final imgWidth = theme.rVal<double?>(s: null, m: 420, l: 360, xl: null);
    final padding = theme.rVal<double>(s: 24, m: 64, l: 32, xl: 48);

    final spacing = theme.rVal<double>(s: 24, m: 32, l: 48, xl: 96);

    return SizedBox(
      height: sectionHeight,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: imgRadius.asRadius(),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  width: imgWidth,
                ),
              ),
            ),
            SizedBox(
              height: spacing,
              width: spacing,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ).expandIf(!collapsed),
            if (!collapsed) const SizedBox(width: 32),
          ],
        ).toColumnIf(collapsed),
      ),
    );
  }
}

extension DynamicSizing on LegendTheme {
  T rVal<T>({
    required T s,
    required T m,
    required T l,
    required T xl,
  }) {
    final key = sizing.key;
    if (key == splits.first) return s;
    if (key == splits[1]) return m;
    if (key == splits[2]) return l;
    if (key == splits.last) return xl;
    return m;
  }
}
