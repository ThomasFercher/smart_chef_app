import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/section/legend_section.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_design_widgets/datadisplay/header/legend_header.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';

import '../widgets/icon_container.dart';
import '../widgets/spacing_container.dart';

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return LegendRouteBody(
      children: [
        LegendSection(
          color: theme.colors.background2,
          padding: EdgeInsets.all(theme.sizing.spacing2),
          borderRadius: BorderRadius.circular(theme.sizing.radius1),
          title: LegendText(
            "Typography",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "The Typographies range from h0 to h5. h5 should be the biggest and will normally be used for titles and headlines.",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing2,
              spacing: theme.sizing.spacing2,
              children: [
                LegendText(
                  "Typography H5",
                  style: theme.typography.h5,
                ),
                LegendText(
                  "Typography H4",
                  style: theme.typography.h4,
                ),
                LegendText(
                  "Typography H3",
                  style: theme.typography.h3,
                ),
                LegendText(
                  "Typography H2",
                  style: theme.typography.h2,
                ),
                LegendText(
                  "Typography H1",
                  style: theme.typography.h1,
                ),
                LegendText(
                  "Typography H0",
                  style: theme.typography.h0,
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
            "Spacing",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "Spacing consists of four fields which get larger with increasing index. ",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing2,
              spacing: theme.sizing.spacing2,
              children: [
                SpacingContainer(
                  width: theme.sizing.spacing1,
                  title: "Spacing 1",
                ),
                SpacingContainer(
                  width: theme.sizing.spacing2,
                  title: "Spacing 2",
                ),
                SpacingContainer(
                  width: theme.sizing.spacing3,
                  title: "Spacing 3",
                ),
                SpacingContainer(
                  width: theme.sizing.spacing4,
                  title: "Spacing 4",
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
            "Icon Sizes",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "Icon Sizes consists of four fields which get larger with increasing index. ",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing2,
              spacing: theme.sizing.spacing2,
              children: [
                IconContainer(
                  size: theme.sizing.iconSize1,
                  title: "IconSize 1",
                ),
                IconContainer(
                  size: theme.sizing.iconSize2,
                  title: "IconSize 2",
                ),
                IconContainer(
                  size: theme.sizing.iconSize3,
                  title: "IconSize 3",
                ),
                IconContainer(
                  size: theme.sizing.iconSize4,
                  title: "IconSize 4",
                )
              ],
            ),
          ),
        ),
        LegendSection(
          color: theme.colors.background2,
          padding: EdgeInsets.all(theme.sizing.spacing2),
          borderRadius: BorderRadius.circular(theme.sizing.radius1),
          title: LegendText(
            "Elevation",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "Elevation consists of four fields which get larger with increasing index. ",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing2,
              spacing: theme.sizing.spacing2,
              children: [
                ElevatedBox(
                  elevation: theme.sizing.elevation1,
                  decoration: BoxDecoration(
                    color: theme.colors.background1,
                    borderRadius: theme.sizing.radius1.asRadius(),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 128,
                    height: 128,
                    child: Center(
                      child: LegendText(
                        "Elevation 1",
                        style: theme.typography.h2,
                      ),
                    ),
                  ),
                ),
                ElevatedBox(
                  elevation: theme.sizing.elevation2,
                  decoration: BoxDecoration(
                    color: theme.colors.background1,
                    borderRadius: theme.sizing.radius1.asRadius(),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 128,
                    height: 128,
                    child: Center(
                      child: LegendText(
                        "Elevation 2",
                        style: theme.typography.h2,
                      ),
                    ),
                  ),
                ),
                ElevatedBox(
                  elevation: theme.sizing.elevation3,
                  decoration: BoxDecoration(
                    color: theme.colors.background1,
                    borderRadius: theme.sizing.radius1.asRadius(),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 128,
                    height: 128,
                    child: Center(
                      child: LegendText(
                        "Elevation 3",
                        style: theme.typography.h2,
                      ),
                    ),
                  ),
                ),
                ElevatedBox(
                  elevation: theme.sizing.elevation4,
                  decoration: BoxDecoration(
                    color: theme.colors.background1,
                    borderRadius: theme.sizing.radius1.asRadius(),
                  ),
                  margin: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 128,
                    height: 128,
                    child: Center(
                      child: LegendText(
                        "Elevation 4",
                        style: theme.typography.h2,
                      ),
                    ),
                  ),
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
            "Radius",
            style: theme.typography.h4,
          ),
          child: LegendHeader(
            header: LegendText(
              "Radie consists of four fields which get larger with increasing index. ",
              style: theme.typography.h1,
            ),
            spacing: theme.sizing.spacing2,
            child: DynamicRow(
              verticalSpacing: theme.sizing.spacing2,
              spacing: theme.sizing.spacing2,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: theme.sizing.radius1.asRadius(),
                    color: theme.colors.background4,
                  ),
                  child: Center(
                    child: LegendText(
                      "Radius 1",
                      style: theme.typography.h2.copyWith(
                        color: theme.colors.foreground4,
                      ),
                    ),
                  ),
                  width: 128,
                  height: 96,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: theme.sizing.radius2.asRadius(),
                    color: theme.colors.background4,
                  ),
                  child: Center(
                    child: LegendText(
                      "Radius 2",
                      style: theme.typography.h2.copyWith(
                        color: theme.colors.foreground4,
                      ),
                    ),
                  ),
                  width: 128,
                  height: 96,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: theme.sizing.radius3.asRadius(),
                    color: theme.colors.background4,
                  ),
                  child: Center(
                    child: LegendText(
                      "Radius 3",
                      style: theme.typography.h2.copyWith(
                        color: theme.colors.foreground4,
                      ),
                    ),
                  ),
                  width: 128,
                  height: 96,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: theme.sizing.radius4.asRadius(),
                    color: theme.colors.background4,
                  ),
                  child: Center(
                    child: LegendText(
                      "Radius 4",
                      style: theme.typography.h2.copyWith(
                        color: theme.colors.foreground4,
                      ),
                    ),
                  ),
                  width: 128,
                  height: 96,
                )
              ],
            ),
          ),
        ),
      ].paddingCol(theme.sizing.spacing1),
    );
  }
}
