import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_design_widgets/input/text/legendInputDecoration.dart';
import 'package:legend_design_widgets/input/text/legendTextField.dart';
import 'package:legend_design_widgets/layout/dynamic/row/dynamic_row.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_checkbox.dart';
import 'package:smart_chef_app/features/auth/widgets/legend_input.dart';
import 'package:smart_chef_app/features/recipe/recipe.dart';

class SelectInfoSection extends LegendWidget {
  const SelectInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    final defaultTools = ["Knife", "Fork", "Spoon", "Pan", "Pot", "Bowl"];
    return Container(
      height: context.viewportHeight,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            LegendText("Configure your Recipe", style: theme.typography.h5),
            const SizedBox(height: 32),
            _ConfigSection(
              title: "Select your avaiable Kitchen Tools",
              subtitle: "",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // LegendInput(
                  //   decoration: geLoginDecoration(theme, null),
                  // ),
                  const SizedBox(height: 12),
                  DynamicRow(
                    spacing: 12,
                    verticalSpacing: 12,
                    children: [
                      for (var tool in defaultTools)
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              LegendText(tool),
                              LegendAnimatedIcon(
                                icon: Icons.add,
                                theme: LegendAnimtedIconTheme(
                                    enabled: theme.colors.selection,
                                    disabled: theme.colors.foreground1),
                                onPressed: () {},
                                iconSize: 24,
                              )
                            ],
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            _ConfigSection(
              title: "Difficulty",
              child: Container(
                child: GridView.count(
                  children: [
                    ElevatedCard(
                      onTap: () {},
                      elevation: 1,
                      background: theme.colors.background3,
                      borderRadius: theme.sizing.radius1.asRadius(),
                      child: Container(
                        height: 120,
                        //  width: 240,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: LegendText(
                                "Easy",
                                style: theme.typography.h3,
                              ),
                            ),
                            Positioned(
                              right: 16,
                              top: 16,
                              child: LegendCheckbox(
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: 16 / 9,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _ConfigSection(
              title: "Ingredient Selection",
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfigSection extends LegendWidget {
  final String? title;
  final String? subtitle;
  final Widget child;

  const _ConfigSection({
    Key? key,
    this.title,
    this.subtitle,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: theme.sizing.radius1.asRadius(),
        color: theme.colors.background2,
      ),
      padding: EdgeInsets.all(theme.sizing.spacing2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            LegendText(
              title,
              style: theme.typography.h3,
              margin: EdgeInsets.only(bottom: 16),
            ),
          if (subtitle != null)
            LegendText(
              subtitle,
              style: theme.typography.h1,
              margin: EdgeInsets.only(bottom: 12),
            ),
          child,
        ],
      ),
    );
  }
}
