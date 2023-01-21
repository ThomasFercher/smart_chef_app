import 'package:flutter/material.dart';
import 'package:legend_design_core/interfaces/legend_config.dart';
import 'package:legend_design_core/legend_app.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_utils/logging/logger.dart';
import 'package:legend_utils/urlstrategy/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/colors.dart';
import 'config/layout.dart';
import 'config/routes.dart';
import 'config/sizing.dart';
import 'config/typography.dart';

const colorThemeKey = 'colorTheme';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final pref = await SharedPreferences.getInstance();
  final key = pref.getString(colorThemeKey);
  final initalColorTheme = key == null ? PaletteType.light() : PaletteType(key);

  Logger.log("Inital Color Theme: ${initalColorTheme.key}", 'main');

  runApp(
    LegendApp(
      config: LegendConfig(
        colorsDelegate: AppColors(),
        sizingDelegate: AppSizing(),
        typographyDelegate: AppTypography(),
        layoutDelegate: AppLayout(),
        routesDelegate: AppRoutes(),
        initalColors: initalColorTheme,
      ),
      logoBuilder: (_) => Image.asset("assets/legend_logo.png"),
      title: "Legend Template",
      buildSplashscreen: (context, theme) {
        return Container(
          color: theme.colors.primary,
        );
      },
    ),
  );
}
