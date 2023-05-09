import 'package:flutter/material.dart';
import 'package:legend_design_core/interfaces/size_delegate.dart';
import 'package:legend_design_core/styles/sizing/core/core_sizing.dart';
import 'package:legend_design_core/styles/sizing/core/override.dart';
import 'package:legend_design_core/styles/sizing/core/legend_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/legend_sub_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/tabbar/tabbar_sizing.dart';
import 'package:legend_design_core/styles/typography/style/typography_sizing.dart';
import 'package:legend_utils/legend_utils.dart';

class AppSizing extends SizingDelegate {
  @override
  LegendSizing get defaultSizing {
    return LegendSizing(
      custom: {
        'settingsWidth': 320,
      },
      key: 720,
      elevation1: 0,
      elevation2: 0,
      elevation3: 0,
      elevation4: 0,
      iconSize1: 16,
      iconSize2: 24,
      iconSize3: 28,
      iconSize4: 32,
      radius1: 8,
      radius2: 12,
      radius3: 16,
      radius4: 20,
      spacing1: 16,
      spacing2: 24,
      spacing3: 36,
      spacing4: 48,
      subSizing: (LegendCoreSizing sizing) {
        return LegendSubSizing(
          typographySizing: TypographySizing(
            h0: 12,
            h1: 14,
            h2: 18,
            h3: 24,
            h4: 32,
            h5: 42,
          ),
          footerSizing: FooterSizing(
            maxWidth: 1000,
            padding: EdgeInsets.zero,
          ),
          siderSizing: SiderSizing(
            width: 200,
            iconSize: 18,
            spacing: 8,
            padding: const EdgeInsets.only(
              top: 16,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            buildComponents: (sider) {
              return SiderSizingComponents(
                sideMenuSizing: SideMenuSizing(
                  spacing: 8,
                  borderRadius: sizing.radius1.asRadius(),
                  iconSize: sizing.iconSize2,
                  itemHeight: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                ),
              );
            },
          ),
          appBarSizing: AppBarSizing(
            appBarHeight: 80,
            contentPadding: const EdgeInsets.only(
              right: 12,
              left: 16,
            ),
            iconSize: 28,
            spacing: 4,
            logoSize: 72,
            buildComponents: (AppBarSizingInfo appBar) {
              return AppBarSizingComponents(
                menuSizing: MenuSizing(
                  spacing: 16,
                  borderRadius: sizing.radius2.asRadius(),
                  iconSize: sizing.iconSize1,
                  height: appBar.appBarHeight - 32,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemSpacing: 8,
                ),
                subMenuSizing: SideMenuSizing(
                  spacing: 21,
                  borderRadius: 21.0.asRadius(),
                  iconSize: sizing.iconSize1,
                  itemHeight: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                  ),
                ),
                tabbarSizing: TabbarSizing(
                  height: 56,
                  alignment: MainAxisAlignment.start,
                ),
              );
            },
          ),
          menuDrawerSizing: MenuDrawerSizing(
            width: 320,
            iconSize: 24,
            itemHeight: 48,
            spacing: 8,
            itemPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            subMenuHeaderHeight: 48,
            subItemPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2,
            ),
            subMenuIconSize: 12,
            buildComponents: (MenuDrawerSizingInfo menu) {
              return MenuDrawerSizingComponents(
                sideMenuSizing: SideMenuSizing(
                  spacing: menu.spacing,
                  borderRadius: sizing.radius1.asRadius(),
                  iconSize: sizing.iconSize2,
                  itemHeight: menu.itemHeight,
                  padding: menu.itemPadding,
                ),
              );
            },
          ),
          bottomBarSizing: BottomBarSizing(
            iconSize: 24,
            height: 80,
            itemWidth: 72,
            margin: EdgeInsets.zero,
            itemPadding: const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            alignment: MainAxisAlignment.spaceAround,
            showText: true,
            fillBottom: true,
            textAtBottom: true,
          ),
        );
      },
    );
  }

  @override
  List<LegendSizingOverride>? get overrides {
    return [
      LegendSizingOverride(
        key: 480,
        spacing1: 12,
        spacing2: 16,
        spacing3: 20,
        spacing4: 24,
        subSizing: (sizing) {
          return LegendSubSizingOverride(
            typographySizing: TypographySizingOverride(
              h0: 10,
              h1: 12,
              h2: 14,
              h3: 22,
              h4: 26,
              h5: 32,
            ),
            appBarSizing: AppBarSizingOverride(
              spacing: 24,
              //  iconSize: 24,
              appBarHeight: 64,
              logoSize: 48,
              buildComponents: (sizing) => AppBarSizingComponentsOverride(
                tabbarSizing: TabbarSizingOverride(
                  height: 48,
                  alignment: MainAxisAlignment.start,
                ),
              ),
            ),
            bottomBarSizing: BottomBarSizingOverride(
              iconSize: 22,
              padding: const EdgeInsets.symmetric(vertical: 6),
              height: 72,
            ),
            menuDrawerSizing: MenuDrawerSizingOverride(
              iconSize: 40,
              itemHeight: 64,
              width: 240,
            ),
          );
        },
      ),
      LegendSizingOverride(
        key: 800,
        spacing1: 16,
        spacing2: 20,
        spacing3: 24,
        spacing4: 32,
        subSizing: (sizing) {
          return LegendSubSizingOverride(
            appBarSizing: AppBarSizingOverride(
              appBarHeight: 64,
              logoSize: 48,
            ),
            typographySizing: TypographySizingOverride(
              h0: 12,
              h1: 14,
            ),
            siderSizing: SiderSizingOverride(
              width: 200,
              buildComponents: (sizing) {
                return SiderSizingComponentsOverride(
                  sideMenuSizing: SideMenuSizingOverride(
                    iconSize: 12,
                    spacing: 4,
                  ),
                );
              },
            ),
          );
        },
      ),
      LegendSizingOverride(
        key: 1200,
        subSizing: (sizing) {
          return LegendSubSizingOverride(
            typographySizing: TypographySizingOverride(
              h0: 13,
              h1: 15,
            ),
            siderSizing: SiderSizingOverride(
              width: 220,
            ),
            appBarSizing: AppBarSizingOverride(
              buildComponents: (sizing) {
                return AppBarSizingComponentsOverride();
              },
            ),
          );
        },
      ),
      LegendSizingOverride(
        key: 1920,
        subSizing: (sizing) {
          return LegendSubSizingOverride(
            typographySizing: TypographySizingOverride(
              h0: 14,
              h1: 16,
            ),
            siderSizing: SiderSizingOverride(
              width: 240,
            ),
          );
        },
      ),
    ];
  }
}
