import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/interfaces/legend_config.dart';
import 'package:legend_design_core/legend_app.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_utils/logging/logger.dart';
import 'package:legend_utils/urlstrategy/url_strategy.dart';
import 'config/colors.dart';
import 'config/layout.dart';
import 'config/routes.dart';
import 'config/sizing.dart';
import 'config/typography.dart';
import 'services/db_service.dart';

const colorThemeKey = 'colorTheme';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await DB.initDB();

  final key = DB.prefs.getString(colorThemeKey);
  final initalColorTheme = key == null ? PaletteType.light() : PaletteType(key);
  Logger.log("Inital Color Theme: ${initalColorTheme.key}", 'main');

  runApp(
    ProviderScope(
      child: LegendApp(
        config: LegendConfig(
          colorsDelegate: AppColors(),
          sizingDelegate: AppSizing(),
          typographyDelegate: AppTypography(),
          layoutDelegate: AppLayout(),
          routesDelegate: AppRoutes(),
          initalColors: initalColorTheme,
        ),
        logoBuilder: (_) => SvgPicture.asset(
          "assets/logo.svg",
          color: LegendTheme.of(_).colors.primary,
          height: LegendTheme.of(_).appBarSizing.appBarHeight,
        ),
        title: "Legend Template",
        buildSplashscreen: (context, theme) {
          return Container(
            color: theme.colors.primary,
          );
        },
      ),
    ),
  );
}
