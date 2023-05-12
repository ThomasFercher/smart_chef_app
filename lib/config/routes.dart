import 'package:flutter/material.dart';
import 'package:legend_design_core/interfaces/layout_delegate.dart';
import 'package:legend_design_core/interfaces/route_delegate.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_utils/extensions/maps.dart';
import 'package:smart_chef_app/config/overrides/auth_route.dart';
import 'package:smart_chef_app/features/auth/signup/signup.dart';
import 'package:smart_chef_app/features/faq/faq.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/pricing/pricing.dart';
import 'package:smart_chef_app/features/privacyPolicy/privacy_policy.dart';
import 'package:smart_chef_app/features/profile/profile.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:smart_chef_app/features/auth/signIn/signIn.dart';
import 'package:smart_chef_app/features/termsOfService/terms_of_service.dart';
import 'package:smart_chef_app/main.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';
import 'layout.dart';

class AppRoutes extends RoutesDelegate {
  @override
  List<RouteInfo> buildRoutes(
    LayoutInfo layouts,
  ) {
    return [
      PageInfo(
        name: HomePage.route,
        title: "Home",
        icon: Icons.home,
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showBackButton: false,
          ),
          layout: layouts.get(PageLayout.home),
        ),
        page: const HomePage(),
        //isMenu: true,
      ),
      AuthPageInfo(
        name: RecipePage.route,
        title: "Recipe",
        icon: Icons.generating_tokens,
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showAppBarMenu: false,
            showBackButton: false,
          ),
          layout: layouts.get(PageLayout.recipe),
        ),
        page: RecipePage(),
        isMenu: true,
      ),

      PageInfo(
        name: SignInScreen.route,
        title: "Sign In",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showAppBarMenu: false,
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.blank),
        ),
        page: const SignInScreen(),
      ),

      PageInfo(
        name: SignUpScreen.route,
        title: "Sign Up",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showAppBarMenu: false,
            showBackButton: false,
          ),
          layout: layouts.get(PageLayout.blank),
        ),
        page: const SignUpScreen(),
      ),
      PageInfo(
        name: TermsOfServicePage.route,
        title: "Terms of Service",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.other),
        ),
        page: const TermsOfServicePage(),
      ),
      PageInfo(
        name: PrivacyPolicyPage.route,
        title: "Privacy Policy",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.other),
        ),
        page: const PrivacyPolicyPage(),
      ),
      // PageInfo(
      //   name: BlogScreen.route,
      //   title: "Blog",
      //   config: ScaffoldRouteConfig(
      //     whether: ScaffoldWhetherOverride(
      //       showBackButton: true,
      //     ),
      //     layout: layouts.get(PageLayout.home),
      //   ),
      //   page: const BlogScreen(),
      //   isMenu: true,
      // ),
      PageInfo(
        name: ProfileScreen.route,
        title: "Profile",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.other),
        ),
        page: const ProfileScreen(),
        isMenu: false,
      ),
      PageInfo(
        name: PricingScreen.route,
        title: "Pricing",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.other),
        ),
        page: const PricingScreen(),
        isMenu: true,
        icon: Icons.price_change,
      ),
      PageInfo(
        name: FAQScreen.route,
        title: "FAQ",
        config: ScaffoldConfigOverride(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.other),
        ),
        page: const FAQScreen(),
        icon: Icons.question_mark,
        isMenu: true,
      ),
      const ModalRouteInfo(
        title: "Home",
        name: MenuDrawer.route,
        page: MenuDrawer(),
      ),
    ];
  }

  @override
  bool hideRoutes(RouteInfo c, BuildContext context) {
    final unauthenticated = globalProvider.read(authProvider) is! Authenticated;
    if (unauthenticated) {
      if (c.name == RecipePage.route) {
        return true;
      }
    }

    return false;
  }
}
