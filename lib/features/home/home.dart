import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/navigation/section/legend_section.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/datadisplay/carousel/legend_carousel.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_chef_app/features/home/widgets/animate_in_widget.dart';

// ConstrainedBox(
//   constraints: const BoxConstraints(maxWidth: 720),
//   child: LegendText(
//     "Welcome to Smartchef, the ultimate AI-powered cooking assistant designed to make your culinary journey seamless and enjoyable. Whether you're a cooking novice or a seasoned chef, our platform offers a range of innovative features that cater to all your kitchen needs. From generating personalized recipes and meal plans to answering your cooking queries, Smartchef is here to help you save time, reduce stress, and elevate your home dining experience. Embrace the future of cooking with Smartchef – your one-stop destination for all things culinary.",
//     textAlign: TextAlign.center,
//     style: theme.typography.h2,
//   ),
// ),

const kSlideInDuration = Duration(milliseconds: 500);
const kSlideCurve = Curves.easeInOut;
const kAnimDelay = Duration(milliseconds: 500);

class HomePage extends LegendWidget {
  static String route = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final spacer3 = theme.rVal<double>(s: 96, m: 96, l: 48, xl: 144).vSpacing;
    final collapsed = theme.rVal(s: true, m: true, l: false, xl: false);

    return LegendRouteBody(
      maxContentWidth: 1440,
      disableContentDecoration: true,
      children: (controller, s) {
        return [
          Container(
            decoration: BoxDecoration(
              color: theme.colors.background2,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(64),
              ),
            ),
            width: context.width,
            padding: const EdgeInsets.all(48).copyWith(
              right: !collapsed ? 24 : 48,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: collapsed
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LegendText(
                      "Take Your Cooking to the Next Level",
                      style: theme.typography.h5,
                      textAlign: collapsed ? TextAlign.center : TextAlign.left,
                    ),
                    32.vSpacing,
                    LegendText(
                      "Smartchef is your Ultimate AI-Powered Cooking Companion",
                      style: theme.typography.h4,
                      color: theme.colors.foreground2,
                      textAlign: collapsed ? TextAlign.center : TextAlign.left,
                    ),
                    64.vSpacing,
                    LegendButton(
                      borderRadius: 32.0.asRadius(),
                      height: 64,
                      width: 320,
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
                            style: theme.typography.h3,
                            color: theme.colors.onPrimary,
                          ),
                          const SizedBox(
                            width: 4,
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
                ).expandIf(!collapsed),
                32.spacing,
                AnimateIn(
                  uKey: const ValueKey("i20"),
                  offset: const Offset(400, 0),
                  child: Image.asset(
                    "assets/illustrations/i20.png",
                    fit: BoxFit.contain,
                  ),
                ).expandIf(!collapsed),
              ],
            ).toColumnIf(collapsed, mainAxisSize: MainAxisSize.min),
          ),
          const LegendSection(
            child: LegendCarousel(
              height: 800,
              items: [
                Center(child: LegendText("Exmaple 1")),
                Center(child: LegendText("Exmaple 2")),
                Center(child: LegendText("Exmaple 3")),
              ],
            ),
          ),
          spacer3,
          _InfoSection(
            collapsed: collapsed,
            image: "assets/illustrations/i13.png",
            inverted: collapsed,
            content: [
              LegendText(
                "Recipe Generation",
                style: theme.typography.h4,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 16,
              ),
              LegendText(
                "Are you tired of cooking the same old dishes? With Smartchef's AI-powered Recipe Generator, you can instantly create unique and delicious recipes tailored to your tastes and preferences. Just enter the ingredients you have on hand or select a specific cuisine, and let our AI work its magic! Explore a world of gastronomic delights and surprise yourself with new, mouth-watering dishes every day.",
                textAlign: TextAlign.left,
                style: theme.typography.h2,
              ),
            ],
          ),
          spacer3,
          _InfoSection(
            collapsed: collapsed,
            image: "assets/illustrations/i05.png",
            inverted: true,
            content: [
              LegendText("Meal Planner", style: theme.typography.h4),
              const SizedBox(
                height: 16,
              ),
              LegendText(
                "Struggling to plan your meals for the week? Say goodbye to last-minute grocery runs and food-related stress! Smartchef's AI-powered Mealplan Generator is here to make your life easier. Based on your dietary preferences, allergies, and time constraints, our AI will craft a comprehensive meal plan tailored to your needs. Save time, eat healthily, and enjoy a variety of delicious meals throughout the week.",
                style: theme.typography.h2,
              ),
            ],
          ),
          spacer3,
          _InfoSection(
            collapsed: collapsed,
            inverted: collapsed,
            image: "assets/illustrations/i17.png",
            content: [
              LegendText(
                "Personal AI Assistant",
                style: theme.typography.h4,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 16,
              ),
              LegendText(
                "Have a cooking question? Need advice on ingredient substitutions or cooking techniques? Smartchef's AI-powered Cooking Assistant is here",
                textAlign: TextAlign.left,
                style: theme.typography.h2,
              ),
            ],
          ),
          spacer3,
        ];
      },
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String image;
  final List<Widget> content;
  final bool inverted;
  final bool collapsed;

  const _InfoSection({
    required this.image,
    required this.content,
    this.inverted = false,
    required this.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final imgRadius = theme.rVal<double>(
      s: 24,
      m: 24,
      l: 64,
      xl: 64,
    );
    final sectionHeight = theme.rVal<double?>(
      s: null,
      m: null,
      l: 420,
      xl: 512,
    );
    final imgWidth = theme.rVal<double?>(
      s: null,
      m: null,
      l: 400.min((context.width / 2) - 40),
      xl: null,
    );
    final padding = theme.rVal<double>(s: 24, m: 64, l: 32, xl: 48);
    final spacing = theme.rVal<double>(s: 24, m: 32, l: 48, xl: 96);
    final _img = Center(
      child: ClipRRect(
        borderRadius: imgRadius.asRadius(),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          width: imgWidth,
        ),
      ),
    );

    final _content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    ).expandIf(!collapsed);

    final insetX = context.width * 0.15;
    final insetY = context.height * 0.09;

    return AnimateIn(
      uKey: ValueKey(image),
      offset: inverted ? Offset(-insetX, -insetY) : Offset(insetX, -insetY),
      child: SizedBox(
        height: sectionHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (inverted) _content else _img,
              SizedBox(
                height: spacing,
                width: spacing,
              ),
              if (inverted) _img else _content,
            ],
          ).toColumnIf(collapsed),
        ),
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

extension LayoutUtilFix on num {
  double get asDouble {
    if (this is double) return this as double;
    if (this is int) return (this as int).toDouble();
    return toDouble();
  }
}

extension LayoutUtil on num? {
  double? get asDouble {
    if (this == null) return null;
    if (this is double) return this as double;
    if (this is int) return (this as int).toDouble();
    return this!.toDouble();
  }

  SizedBox get vSpacing => SizedBox(height: asDouble);

  SizedBox get hSpacing => SizedBox(width: asDouble);

  SizedBox get spacing => SizedBox(width: asDouble, height: asDouble);

  double max(num v) {
    if (this == null) return v.asDouble;
    return this!.asDouble > v ? this!.asDouble : v.asDouble;
  }

  double min(num v) {
    if (this == null) return v.asDouble;
    return this!.asDouble < v ? this!.asDouble : v.asDouble;
  }
}

extension ContextUtil on BuildContext {
  LegendTheme get theme => LegendTheme.of(this);

  double get width => SizeInfo.of(this).width;

  double get height => SizeInfo.of(this).height;
}
