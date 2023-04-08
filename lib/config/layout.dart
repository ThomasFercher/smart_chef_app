import 'package:legend_design_core/interfaces/layout_delegate.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_layout.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/footer/footer_layout.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/sider/sider_layout.dart';
import 'package:smart_chef_app/widgets/themeSwitcher/themeSwitcher.dart';

import '../features/footer/footer.dart';

enum PageLayout {
  recipe,
  home,
  blank,
}

class AppLayout extends LayoutDelegate {
  @override
  LayoutInfo buildLayouts(splits) {
    return {
      PageLayout.recipe: DynamicRouteLayout.override(
        splits,
        defaultLayout: RouteLayout(
          appBarLayout: AppBarLayout(
            layout: AppBarLayoutConfig.body,
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
      ),
      PageLayout.home: DynamicRouteLayout.override(
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
      ),
      PageLayout.blank: DynamicRouteLayout.override(
        splits,
        defaultLayout: RouteLayout(
          appBarLayout: NoAppBarLayout(),
          bottomBarLayout: NoBottomBarLayout(),
          footerLayout: NoFooterLayout(),
          siderLayout: NoSiderLayout(),
          menuDrawerLayout: NoMenuDrawerLayout(),
        ),
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
        customFooter: const Footer(),
        appBarActions: (p0, p1) {
          return const ThemeSwitcher();
        },
      ),
    );
  }
}
