import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/navigation/section/legend_section.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/datadisplay/carousel/legend_carousel.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_design_widgets/scrolling/effects/visibility_sliver.dart';
import 'package:smart_chef_app/features/auth/signup/signup.dart';
import 'package:smart_chef_app/features/footer/footer.dart';
import 'package:smart_chef_app/features/home/widgets/animate_in_widget.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';

const kSlideInDuration = Duration(milliseconds: 500);
const kSlideCurve = Curves.easeInOut;
const kAnimDelay = Duration(milliseconds: 500);

class HomePage extends ConsumerWidget {
  static String route = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = context.theme;
    final spacer3 = theme.rVal<double>(s: 96, m: 96, l: 48, xl: 144).vSpacing;
    final collapsed = theme.rVal(s: true, m: true, l: false, xl: false);
    final margin = theme.rVal<double>(s: 12, m: 24, l: 48, xl: 64);

    return LegendRouteBody(
      maxContentWidth: 1440,
      disableContentDecoration: true,
      sliverAppBar: LegendSliverBar(
        config: LegendAppBarConfig(
          appBarHeight: theme.sizing.appBarSizing.appBarHeight,
          elevation: 0.5,
          floating: true,
        ),
        actions: ScaffoldInfo.of(context).scaffold.builders.appBarActions,
      ),
      slivers: (controller) {
        return [
          Container(
            decoration: BoxDecoration(
              color: theme.colors.background2,
              borderRadius: const BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            width: context.width,
            padding: const EdgeInsets.all(48).copyWith(
              right: !collapsed ? 24 : 48,
            ),
            margin: EdgeInsets.all(margin),
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
                      selBackground: theme.colors.selection,
                      selElevation: 1,
                      elevation: 0,
                      background: theme.colors.primary,
                      onTap: () {
                        if (ref.read(authProvider) is Authenticated) {
                          LegendRouter.of(context).pushPage(RecipePage.route);
                          return;
                        }
                        LegendRouter.of(context).pushPage(SignUpScreen.route);
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
                            width: 6,
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: theme.colors.onPrimary,
                            size: 32,
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
          ).toSliver(),
          const LegendSection(
            child: LegendCarousel(
              height: 800,
              items: [
                Center(child: LegendText("Exmaple 1")),
                Center(child: LegendText("Exmaple 2")),
                Center(child: LegendText("Exmaple 3")),
              ],
            ),
          ).toSliver(),
          spacer3.toSliver(),
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
          spacer3.toSliver(),
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
          spacer3.toSliver(),
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
          spacer3.toSliver(),
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
    final insetY = context.height * 0.1;

    return SliverVis(
      type: VisibilityType.ONCE,
      binary: true,
      binaryThreshold: 0.5,
      builder: (context, child, visible) {
        final vis = visible == 1;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(
            0,
            vis ? 0 : insetY,
            0,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: visible,
            child: child,
          ),
        );
      },
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

  bool get isSmall => sizing.key == splits.first;

  bool get isMedium => sizing.key == splits[1];

  bool get isLarge => sizing.key == splits[2];

  bool get isXLarge => sizing.key == splits.last;
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

extension SliverUtil on Widget {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);
}

extension SliverUtil2 on List<Widget> {
  SliverList toSliver() => SliverList(
        delegate: SliverChildListDelegate(this),
      );
}
