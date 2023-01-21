import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_widgets/input/text/legendInputDecoration.dart';
import 'package:legend_design_widgets/input/text/legendTextField.dart';
import 'package:legend_utils/legend_utils.dart';

class HomePage extends LegendWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final appBarActions =
        ScaffoldInfo.of(context)!.scaffold.builders.appBarActions;
    final sizeInfo = SizeInfo.of(context);
    return LegendRouteBody(
      sliverAppBar: LegendSliverBar(
        config: LegendAppBarConfig(
          appBarHeight: theme.appBarSizing.appBarHeight,
          elevation: 1,
        ),
        showMenu: false,
        actions: appBarActions,
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: ElevatedCard(
              elevation: 1,
              borderRadius: theme.sizing.radius2.asRadius(),
              child: Container(
                width: sizeInfo.width / 2,
                color: theme.colors.background2,
                padding: EdgeInsets.all(theme.sizing.spacing2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LegendText(
                      "Recipe Generator",
                      style: theme.typography.h4,
                    ),
                    const SizedBox(height: 100),
                    LegendTextField(
                      decoration: LegendInputDecoration.rounded(),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
