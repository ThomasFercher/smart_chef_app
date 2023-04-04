import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:legend_design_core/interfaces/layout_delegate.dart';
import 'package:legend_design_core/interfaces/route_delegate.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/legend_design_core.dart';

import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/extensions/maps.dart';
import 'package:smart_chef_app/features/auth/signup/signup.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/home/home_appbar_actions.dart';
import 'package:smart_chef_app/features/privacyPolicy/privacy_policy.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:smart_chef_app/features/settings/settings.dart';
import 'package:smart_chef_app/features/auth/signIn/signIn.dart';
import 'package:smart_chef_app/features/termsOfService/terms_of_service.dart';
import 'package:smart_chef_app/providers/auth/auth_provider.dart';
import 'package:smart_chef_app/widgets/themeSwitcher/themeSwitcher.dart';
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
        config: ScaffoldRouteConfig(
          whether: ScaffoldWhetherOverride(),
          layout: layouts.get(PageLayout.home),
          builders: ScaffoldBuildersOverride(
            appBarActions: (_, __) => const HomeScreenAppBarActions(),
          ),
        ),
        page: const HomePage(),
        isMenu: true,
      ),
      PageInfo(
        name: RecipePage.route,
        title: "Recipe",
        icon: Icons.generating_tokens,
        config: ScaffoldRouteConfig(
          whether: ScaffoldWhetherOverride(
            showAppBarMenu: false,
            showBackButton: false,
          ),
          layout: layouts.get(PageLayout.recipe),
        ),
        page: const RecipePage(),
        isMenu: true,
      ),
      PageInfo(
        name: SignInScreen.route,
        title: "Sign In",
        config: ScaffoldRouteConfig(
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
        config: ScaffoldRouteConfig(
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
        config: ScaffoldRouteConfig(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.home),
        ),
        page: const TermsOfServicePage(),
      ),
      PageInfo(
        name: PrivacyPolicyPage.route,
        title: "Privacy Policy",
        config: ScaffoldRouteConfig(
          whether: ScaffoldWhetherOverride(
            showBackButton: true,
          ),
          layout: layouts.get(PageLayout.home),
        ),
        page: const PrivacyPolicyPage(),
      ),
      const ModalRouteInfo(
        name: "/settings",
        title: "Home",
        page: Settings(),
      ),
      const ModalRouteInfo(
        name: "/menudrawer",
        title: "Home",
        page: MenuDrawer(),
      ),
    ];
  }
}
