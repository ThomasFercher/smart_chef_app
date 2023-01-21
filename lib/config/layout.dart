import 'package:flutter/material.dart';
import 'package:legend_design_core/interfaces/layout_delegate.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_layout.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/footer/footer_layout.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/sider/sider_layout.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';

import 'widgets/footer.dart';

enum PageLayout {
  header,
  header2,
  headerTabbar,
  headerSider,
}

class AppLayout extends LayoutDelegate {
  @override
  LayoutInfo buildLayouts(splits) {
    return {
      PageLayout.header: DynamicRouteLayout.override(
        splits,
        defaultLayout: RouteLayout(
          appBarLayout: AppBarLayout(
            layout: AppBarLayoutConfig.fixedAbove,
            aligment: AppBarLayoutType.TiMeAc,
            showTabbar: false,
          ),
          bottomBarLayout: NoBottomBarLayout(),
          footerLayout: FooterLayout(),
          siderLayout: NoSiderLayout(),
          menuDrawerLayout: MenuDrawerLayout(
            type: MenuDrawerLayoutType.drawerRight,
          ),
        ),
        overrides: {
          splits.first: RouteLayoutOverride(
            bottomBarLayout: BottomBarLayoutOverride(
              selectionType: BottomBarSelectionType.whole,
            ),
            appBarLayout: AppBarLayoutOverride(
              layout: AppBarLayoutConfig.body,
              aligment: AppBarLayoutType.TiMeAc,
              showTabbar: false,
            ),
            footerLayout: NoFooterLayoutOverride(),
          ),
        },
      ),
      PageLayout.headerTabbar: DynamicRouteLayout.override(
        splits,
        defaultLayout: RouteLayout(
          appBarLayout: AppBarLayout(
            layout: AppBarLayoutConfig.fixedAbove,
            aligment: AppBarLayoutType.TiMeAc,
            showTabbar: true,
          ),
          footerLayout: FooterLayout(),
          siderLayout: NoSiderLayout(),
          bottomBarLayout: NoBottomBarLayout(),
          menuDrawerLayout: NoMenuDrawerLayout(),
        ),
        overrides: {
          splits.first: RouteLayoutOverride(
            bottomBarLayout: BottomBarLayoutOverride(
              selectionType: BottomBarSelectionType.icon,
            ),
            menuDrawerLayout: MenuDrawerLayoutOverride(
              type: MenuDrawerLayoutType.beneathAppBar,
            ),
          ),
        },
      ),
      PageLayout.headerSider: DynamicRouteLayout.override(
        splits,
        defaultLayout: RouteLayout(
          appBarLayout: AppBarLayout(
            layout: AppBarLayoutConfig.fixedAbove,
            aligment: AppBarLayoutType.TiMeAc,
            showTabbar: false,
          ),
          footerLayout: FooterLayout(),
          siderLayout: SiderLayout(
            left: true,
          ),
          bottomBarLayout: NoBottomBarLayout(),
          menuDrawerLayout: NoMenuDrawerLayout(),
        ),
        overrides: {
          splits.first: RouteLayoutOverride(
            bottomBarLayout: BottomBarLayoutOverride(
              selectionType: BottomBarSelectionType.icon,
            ),
            siderLayout: NoSiderLayoutOverride(),
            footerLayout: NoFooterLayoutOverride(),
          ),
          splits[1]: RouteLayoutOverride(
            siderLayout: NoSiderLayoutOverride(),
          ),
        },
      ),
    };
  }

  @override
  ScaffoldConfig get defaultConfig {
    return ScaffoldConfig(
      whether: ScaffoldWhether(
        showBackButton: false,
        showAppBarMenu: true,
        shareParentSiderMenu: false,
        showSiderChildMenu: false,
        showSiderMenu: false,
        showSiderSubMenu: false,
        showTopSubMenu: false,
        singlePage: false,
      ),
      builders: ScaffoldBuilders(
        appBarActions: (c, theme) {
          return LegendAnimatedIcon(
            icon: Icons.color_lens,
            theme: LegendAnimtedIconTheme(
              enabled: theme.colors.selection,
              disabled: theme.colors.appBar.foreground,
            ),
            padding: const EdgeInsets.all(4),
            iconSize: theme.appBarSizing.iconSize,
            disableShadow: true,
            onPressed: () {
              ModalRouter.of(c).push(
                "/settings",
              );
            },
          );
        },
        customFooter: FixedFooter(
          builder: (context, sizing, colors) => const Footer(),
        ),
      ),
    );
  }
}
