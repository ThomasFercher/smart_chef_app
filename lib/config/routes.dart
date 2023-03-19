import 'package:flutter/material.dart';
import 'package:legend_design_core/interfaces/layout_delegate.dart';
import 'package:legend_design_core/interfaces/route_delegate.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';
import 'package:legend_utils/extensions/maps.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';
import 'package:smart_chef_app/features/settings/settings.dart';
import 'package:smart_chef_app/widgets/themeSwitcher/themeSwitcher.dart';

import 'layout.dart';

class AppRoutes extends RoutesDelegate {
  @override
  List<RouteInfo> buildRoutes(
    LayoutInfo layouts,
  ) {
    return [
      PageInfo(
        name: "/",
        title: "Home",
        icon: Icons.home,
        config: ScaffoldRouteConfig(
            whether: ScaffoldWhetherOverride(),
            layout: layouts.get(PageLayout.home),
            builders: ScaffoldBuildersOverride(
              appBarActions: (c, theme) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ThemeSwitcher(),
                    const SizedBox(width: 8),
                    LegendButton(
                      background: theme.appBarColors.background,
                      height: 56,
                      width: 96,
                      selBackground: theme.colors.secondary,
                      borderRadius: theme.sizing.radius1.asRadius(),
                      onTap: () {},
                      text: Text(
                        "Sign In",
                        style: theme.typography.h1.copyWith(
                          color: theme.colors.onSecondary,
                        ),
                      ),
                    ),
                    LegendButton(
                      background: theme.colors.secondary,
                      height: 56,
                      width: 128,
                      borderRadius: theme.sizing.radius1.asRadius(),
                      selElevation: 2,
                      onTap: () {},
                      selBackground: theme.colors.selection,
                      text: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: theme.typography.h1.copyWith(
                              color: theme.colors.onSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: theme.colors.onSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )),
        page: const HomePage(),
      ),
      PageInfo(
        name: "/recipe",
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
