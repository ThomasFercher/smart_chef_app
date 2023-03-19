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
      primary: Colors.grey[900]!,
      secondary: Colors.tealAccent,
      tertiary: Colors.blueGrey,
      foreground1: Colors.white,
      foreground2: const Color(0xFFF3EFCC),
      foreground3: Colors.blueGrey[50]!,
      foreground4: Colors.blueGrey[50]!,
      foreground5: Colors.blueGrey[100]!,
      background1: Colors.black,
      background2: Colors.greenAccent[700]!,
      background3: Colors.grey[800]!,
      background4: Colors.grey[600]!,
      background5: Colors.grey[500]!,
      error: Colors.red[400]!,
      disabled: LegendColors.gray2,
      selection: Colors.tealAccent[400]!,
      onPrimary: Colors.indigo[50]!,
      onSecondary: Colors.teal[200]!,
      onTertiary: Colors.blueGrey[200]!,
      custom: {
        "category": Colors.grey[400]!,
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
            background: colors.background1,
            foreground: colors.onPrimary,
            buildComponents: (appBar) {
              return AppBarColorsComponentsOverride(
                menuColors: MenuColorsOverride(),
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
            background: colors.background2,
            foreground: colors.foreground2,
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

// 1. primary: #00857D (Greenish Teal)
// 2. secondary: #40A9A6 (Light Greenish Teal)
// 3. tertiary: #FF9F40 (Warm Orange)
// 4. onPrimary: #FFFFFF (White)
// 5. onSecondary: #FFFFFF (White)
// 6. onTertiary: #FFFFFF (White)
// 7. error: #D32F2F (Red)
// 8. disabled: #BDBDBD (Light Grey)
// 9. selection: #C8E6C9 (Mint Green)
// 10. foreground1: #2B2B2B (Charcoal Grey)
// 11. foreground2: #616161 (Medium Grey)
// 12. foreground3: #757575 (Light Charcoal Grey)
// 13. foreground4: #9E9E9E (Grey)
// 14. foreground5: #E0E0E0 (Very Light Grey)
// 15. background1: #FAFAFA (Off-White)
// 16. background2: #F5F5F5 (Light Grey)
// 17. background3: #EEEEEE (Lighter Grey)
// 18. background4: #E8E8E8 (Even Lighter Grey)
// 19. background5: #E0E0E0 (Very Light Grey)
  @override
  LegendPalette get lightTheme {
    return LegendPalette(
      primary: const Color(0xFF00857D),
      secondary: const Color(0xFF40A9A6),
      tertiary: const Color(0xFF03C988),
      foreground1: Color(0xFF2B2B2B),
      foreground2: Color(0xFF616161),
      foreground3: Color(0xFF757575),
      foreground4: Color(0xFF9E9E9E),
      foreground5: Color(0xFFF0F0F0),
      background1: Color(0xFFF9F9F9),
      background2: Color(0xFFE0F3F3),
      background3: Color(0xFFD0ECEC),
      background4: Color(0xFFC0E5E5),
      background5: Color(0xFF2B2B2B),
      error: const Color(0xFFD32F2F),
      disabled: Color(0xFFBDBDBD),
      selection: Color(0xFF03C988),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      custom: {
        "custom": Colors.blue,
      },
      subcolors: (colors) {
        return LegendSubColors(
          typography: TypographyColorsOverride(
            h5: colors.primary,
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
                  activeForeground: colors.selection,
                  activeBackground: colors.background1,
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
