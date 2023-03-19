import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/theme_provider.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chef_app/main.dart';

const kLight = Icons.light_mode_outlined;
const kDark = Icons.dark_mode_outlined;

final lightThemeSelectedProvider = StateProvider<bool>((ref) {
  return true;
});

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
          context.read<ThemeProvider>().changeColorTheme(PaletteType.light());
          SharedPreferences.getInstance().then(
            (pref) => pref.setString(colorThemeKey, lightKey),
          );
        } else {
          context.read<ThemeProvider>().changeColorTheme(PaletteType.dark());
          SharedPreferences.getInstance().then(
            (pref) => pref.setString(colorThemeKey, darkKey),
          );
        }
      },
    );

    return LegendAnimatedIcon(
      icon: isLight ? kDark : kLight,
      onPressed: () => ref
          .read(lightThemeSelectedProvider.notifier)
          .update((state) => !state),
      disableShadow: true,
      iconSize: 24,
      theme: LegendAnimtedIconTheme(
        disabled: theme.colors.appBar.foreground,
        enabled: theme.colors.appBar.foreground,
      ),
    );
  }
}
