import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:smart_chef_app/widgets/ingredient_widget.dart';
import 'package:smart_chef_app/widgets/selectable_grid.dart';
import 'package:smart_chef_app/widgets/selectable_list.dart';

class HomePage extends LegendWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final appBarActions =
        ScaffoldInfo.of(context).scaffold.builders.appBarActions;
    final sizeInfo = SizeInfo.of(context);

    final inputSectionHeight = sizeInfo.height -
        theme.sizing.footerSizing.height -
        theme.appBarSizing.appBarHeight;

    return LegendRouteBody(
      singlePage: true,
      sliverAppBar: LegendSliverBar(
        config: LegendAppBarConfig(
          appBarHeight: theme.appBarSizing.appBarHeight,
          elevation: 1,
        ),
        showMenu: false,
        actions: appBarActions,
      ),
      slivers: (scrollcontroller) {
        return [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              width: SizeInfo.of(context).width,
              padding: EdgeInsets.all(
                theme.sizing.spacing1,
              ),
              child: Container(
                color: theme.colors.background1,
                padding: EdgeInsets.all(theme.sizing.spacing2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LegendText(
                      "Select your ingredients",
                      style: theme.typography.h4,
                    ),
                    SizedBox(height: theme.sizing.spacing3),
                    const Expanded(
                      child: IngredientWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
    );
  }
}
