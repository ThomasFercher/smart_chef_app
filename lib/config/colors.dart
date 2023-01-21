import 'package:flutter/material.dart';
import 'package:legend_design_core/interfaces/color_delegate.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/colors/legend_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/appbar/appBar_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/tabbar/tabbar_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/sub_colors.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/style/typography_colors.dart';

class AppColors extends ColorsDelegate {
  @override
  Map<String, LegendPalette>? get customThemes => null;

  @override
  LegendPalette get darkTheme {
    return LegendPalette(
      primary: Colors.indigo[900]!,
      secondary: Colors.tealAccent,
      tertiary: Colors.blueGrey,
      foreground1: Colors.white,
      foreground2: Colors.blueGrey[50]!,
      foreground3: Colors.blueGrey[50]!,
      foreground4: Colors.blueGrey[50]!,
      foreground5: Colors.blueGrey[100]!,
      background1: Colors.grey[850]!,
      background2: Colors.grey[800]!,
      background3: Colors.grey[700]!,
      background4: Colors.grey[600]!,
      background5: Colors.grey[500]!,
      error: Colors.red[400]!,
      disabled: LegendColors.gray2,
      selection: Colors.tealAccent[400]!,
      onPrimary: Colors.indigo[50]!,
      onSecondary: Colors.teal[200]!,
      onTertiary: Colors.blueGrey[200]!,
      custom: {
        "custom": Colors.blue,
      },
      subcolors: (colors) {
        return LegendSubColors(
          typography: TypographyColorsOverride(
            h5: colors.foreground1,
            h4: colors.foreground1,
            h3: colors.foreground1,
            h1: colors.foreground2,
          ),
          appBar: AppBarColorsOverride(
            background: colors.primary,
            foreground: colors.onPrimary,
            buildComponents: (appBar) {
              return AppBarColorsComponentsOverride(
                menuColors: MenuColorsOverride(
                  foreground: appBar.foreground,
                  //   activeBackground: appBar.foreground,
                  menuBackground: appBar.background,
                  background: appBar.background,
                ),
                subMenuColors: SideMenuColorsOverride(
                  foreground: appBar.foreground,
                  background: appBar.background,
                  menuBackground: appBar.background,
                ),
                tabbarColors: TabbarColorsOverride(
                  background: colors.primary,
                ),
              );
            },
          ),
          footer: FooterColorsOverride(
            background: colors.background1,
          ),
          bottomBar: BottomBarColorsOverride(
            backgroundColor: colors.background1,
            activeColor: Colors.indigoAccent,
            disabledColor: Colors.indigoAccent[100],
          ),
          sider: SiderColorsOverride(
            background: colors.primary,
            foreground: colors.onPrimary,
            selection: colors.selection,
            backgroundMenu: colors.primary,
            buildComponents: (sider) {
              return SiderColorsComponentsOverride(
                menuColors: SideMenuColorsOverride(
                  background: colors.primary.darken(0.05),
                  activeForeground: sider.selection,
                  activeBackground: colors.primary.darken(0.1),
                  foreground: sider.foreground,
                  menuBackground: sider.background,
                ),
              );
            },
          ),
          menuDrawer: MenuDrawerColorsOverride(
            background: colors.background1,
            backgroundMenu: colors.onPrimary,
            foreground: colors.foreground1,
            backgroundSelection: colors.primary,
            backgroundMenuSelection: colors.primary,
            buildComponents: (menu) {
              return MenuDrawerColorsComponentsOverride(
                menuColors: SideMenuColorsOverride(
                  menuBackground: menu.background,
                  activeBackground: colors.primary,
                  activeForeground: colors.selection,
                  background: colors.background2,
                  foreground: colors.foreground2,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  LegendPalette get lightTheme {
    return LegendPalette(
      primary: Colors.indigo[900]!,
      secondary: Colors.tealAccent,
      tertiary: Colors.blueGrey,
      foreground1: Colors.blueGrey[900]!,
      foreground2: Colors.blueGrey[800]!,
      foreground3: Colors.indigo[600]!,
      foreground4: Colors.indigo[100]!,
      foreground5: Colors.indigo[50]!,
      background1: Colors.indigo[50]!,
      background2: Colors.indigo[100]!,
      background3: Colors.indigo[200]!,
      background4: Colors.indigo[600]!,
      background5: Colors.blueGrey[800]!,
      error: Colors.red[400]!,
      disabled: LegendColors.gray7,
      selection: Colors.tealAccent[400]!,
      onPrimary: Colors.indigo[100]!,
      onSecondary: Colors.teal[200]!,
      onTertiary: Colors.blueGrey[200]!,
      custom: {
        "custom": Colors.blue,
      },
      subcolors: (colors) {
        return LegendSubColors(
          typography: TypographyColorsOverride(
            h5: colors.foreground1,
            h4: colors.foreground1,
            h3: colors.foreground1,
            h1: colors.foreground2,
          ),
          appBar: AppBarColorsOverride(
            background: colors.primary,
            foreground: colors.onPrimary,
            buildComponents: (appBar) {
              return AppBarColorsComponentsOverride(
                menuColors: MenuColorsOverride(
                  foreground: appBar.foreground,
                  menuBackground: appBar.background,
                  background: appBar.background,
                ),
                subMenuColors: SideMenuColorsOverride(
                  foreground: appBar.foreground,
                  background: appBar.background,
                  menuBackground: appBar.background,
                ),
                tabbarColors: TabbarColorsOverride(
                  background: colors.background1,
                ),
              );
            },
          ),
          footer: FooterColorsOverride(
            background: colors.background5,
          ),
          bottomBar: BottomBarColorsOverride(
            backgroundColor: colors.background1,
            activeColor: Colors.indigoAccent,
            disabledColor: Colors.indigoAccent[100],
          ),
          sider: SiderColorsOverride(
            background: colors.primary,
            foreground: colors.foreground5,
            selection: colors.selection,
            backgroundMenu: colors.primary,
            buildComponents: (sider) {
              return SiderColorsComponentsOverride(
                menuColors: SideMenuColorsOverride(
                  background: colors.primary.darken(0.05),
                  activeForeground: sider.selection,
                  activeBackground: colors.primary.darken(0.1),
                  foreground: sider.foreground,
                  menuBackground: sider.background,
                ),
              );
            },
          ),
          menuDrawer: MenuDrawerColorsOverride(
            background: Colors.white,
            backgroundMenu: colors.onPrimary,
            foreground: colors.primary,
            backgroundMenuSelection: colors.primary,
            backgroundSelection: colors.primary,
            buildComponents: (menu) {
              return MenuDrawerColorsComponentsOverride(
                menuColors: SideMenuColorsOverride(
                  menuBackground: menu.background,
                  activeBackground: colors.primary,
                  activeForeground: colors.selection,
                  background: menu.background,
                  foreground: menu.foreground,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
