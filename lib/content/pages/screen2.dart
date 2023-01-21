import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/section/legend_section.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/datadisplay/header/legend_header.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';

import '../widgets/color_container.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    return LegendRouteBody(
      disableContentDecoration: false,
      children: [
        Builder(builder: (context) {
          final theme = LegendTheme.of(context);
          return LegendSection(
            color: theme.colors.background2,
            padding: EdgeInsets.all(theme.sizing.spacing2),
            borderRadius: BorderRadius.circular(theme.sizing.radius1),
            title: LegendText(
              "Core",
              style: theme.typography.h4,
            ),
            child: LegendHeader(
              header: LegendText(
                "The Core Colors represent the backbone of your Color Theme. These will be used throughout the whole application and used for SubThemes of Components.",
                style: theme.typography.h1,
              ),
              spacing: theme.sizing.spacing2,
              child: DynamicRow(
                verticalSpacing: theme.sizing.spacing1,
                spacing: theme.sizing.spacing2,
                children: [
                  ColorContainer(
                    color: theme.colors.primary,
                    title: "Primary",
                  ),
                  ColorContainer(
                    color: theme.colors.onPrimary,
                    title: "On Primary",
                  ),
                  ColorContainer(
                    color: theme.colors.secondary,
                    title: "Secondary",
                  ),
                  ColorContainer(
                    color: theme.colors.onSecondary,
                    title: "On Secondary",
                  ),
                  ColorContainer(
                    color: theme.colors.tertiary,
                    title: "Tertiary",
                  ),
                  ColorContainer(
                    color: theme.colors.onTertiary,
                    title: "On Tertiary",
                  ),
                  ColorContainer(
                    color: theme.colors.disabled,
                    title: "Disabled",
                  ),
                  ColorContainer(
                    color: theme.colors.error,
                    title: "Error",
                  ),
                ],
              ),
            ),
          );
        }),
        LegendSection(
          color: theme.colors.background2,
          padding: EdgeInsets.all(theme.sizing.spacing2),
          borderRadius: BorderRadius.circular(theme.sizing.radius1),
          title: LegendText(
            "Foreground",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "Foreground Colors are expected to be used for Typography and Content which faces the user. Also the Foreground 1 Color should contrast the matching Background 1 Color.",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing1,
              spacing: theme.sizing.spacing2,
              children: [
                ColorContainer(
                  color: theme.colors.foreground1,
                  title: "Foreground 1",
                ),
                ColorContainer(
                  color: theme.colors.foreground2,
                  title: "Foreground 2",
                ),
                ColorContainer(
                  color: theme.colors.foreground3,
                  title: "Foreground 3",
                ),
                ColorContainer(
                  color: theme.colors.foreground4,
                  title: "Foreground 4",
                ),
                ColorContainer(
                  color: theme.colors.foreground5,
                  title: "Foreground 5",
                ),
              ],
            ),
          ),
        ),
        LegendSection(
          color: theme.colors.background2,
          padding: EdgeInsets.all(theme.sizing.spacing2),
          borderRadius: BorderRadius.circular(theme.sizing.radius1),
          title: LegendText(
            "Background",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "Background Colors are expected to be used for Backgrounds and Content which is behind other Content. Also each Background Color should contrast the matching Foreground Color.",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing1,
              spacing: theme.sizing.spacing2,
              children: [
                ColorContainer(
                  color: theme.colors.background1,
                  title: "Background 1",
                ),
                ColorContainer(
                  color: theme.colors.background2,
                  title: "Background 2",
                ),
                ColorContainer(
                  color: theme.colors.background3,
                  title: "Background 3",
                ),
                ColorContainer(
                  color: theme.colors.background4,
                  title: "Background 4",
                ),
                ColorContainer(
                  color: theme.colors.background5,
                  title: "Background 5",
                ),
              ],
            ),
          ),
        ),
      ].paddingCol(theme.sizing.spacing1),
    );
  }
}
