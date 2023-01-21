import 'package:flutter/material.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/theme_provider.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/animated_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ThemeSelector(),
        ],
      ),
      color: theme.colors.background2,
      width: theme.sizing.get("settingsWidth"),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(
        theme.sizing.spacing2,
      ),
    );
  }
}

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  late bool _hovered;

  @override
  void initState() {
    _hovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    final colorTheme = context.watch<ThemeProvider>().colorTheme;
    final width = theme.sizing.get("settingsWidth");
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LegendText(
            "Color Theme",
            style:
                theme.typography.h5.copyWith(color: theme.colors.foreground1),
            selectable: false,
          ),
          Divider(
            height: theme.sizing.spacing3,
          ),
          AnimatedCard(
            borderRadius: theme.sizing.radius4.asRadius(),
            background: colorTheme.dark.background1,
            elevation: 1,
            onTap: () {
              context
                  .read<ThemeProvider>()
                  .changeColorTheme(PaletteType.dark());

              SharedPreferences.getInstance().then(
                (pref) => pref.setString(colorThemeKey, darkKey),
              );
            },
            padding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              width: width / 1.8,
              height: width / 1.8,
              child: LegendText(
                "Dark",
                style: theme.typography.h3.copyWith(
                  color: colorTheme.dark.foreground1,
                ),
                selectable: false,
              ),
            ),
          ),
          SizedBox(
            height: theme.sizing.spacing2,
          ),
          AnimatedCard(
            borderRadius: theme.sizing.radius4.asRadius(),
            background: colorTheme.light.background1,
            elevation: 1,
            onTap: () {
              context
                  .read<ThemeProvider>()
                  .changeColorTheme(PaletteType.light());
              SharedPreferences.getInstance().then(
                (pref) => pref.setString(colorThemeKey, lightKey),
              );
            },
            padding: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              width: width / 1.8,
              height: width / 1.8,
              child: LegendText(
                "Light",
                style: theme.typography.h3,
                selectable: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
