import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/theme_state.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chef_app/main.dart';
import 'package:smart_chef_app/services/db_service.dart';

const kLight = Icons.light_mode;
const kDark = Icons.dark_mode;

final lightThemeSelectedProvider =
    StateProvider<bool>((ref) => DB.prefs.getString(colorThemeKey) == lightKey);

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isLight = ref.watch(lightThemeSelectedProvider);
    final theme = LegendTheme.of(context);

    ref.listen<bool>(
      lightThemeSelectedProvider,
      (previous, next) {
        if (next) {
          ThemeState.changeColorTheme(context, PaletteType.light());
          SharedPreferences.getInstance().then(
            (pref) => pref.setString(colorThemeKey, lightKey),
          );
        } else {
          ThemeState.changeColorTheme(context, PaletteType.dark());
          SharedPreferences.getInstance().then(
            (pref) => pref.setString(colorThemeKey, darkKey),
          );
        }
      },
    );

    final appBarHeight = theme.appBarSizing.appBarHeight;
    const paddingVertical = 12.0;

    return Container(
      width: appBarHeight - paddingVertical * 2,
      padding: const EdgeInsets.symmetric(vertical: paddingVertical),
      child: LegendDetector(
        onTap: () => ref
            .read(lightThemeSelectedProvider.notifier)
            .update((state) => !state),
        background: theme.colors.background3,
        borderRadius: theme.sizing.radius2.asRadius(),
        child: Center(
          child: Icon(
            isLight ? kDark : kLight,
            size: 24,
            color: isLight ? theme.colors.primary : theme.colors.foreground1,
          ),
        ),
      ),
    );
  }
}
