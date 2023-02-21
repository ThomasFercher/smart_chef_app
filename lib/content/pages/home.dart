import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
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
        ScaffoldInfo.of(context)!.scaffold.builders.appBarActions;
    final sizeInfo = SizeInfo.of(context);

    final inputSectionHeight = sizeInfo.height -
        theme.sizing.footerSizing.height -
        theme.appBarSizing.appBarHeight;
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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: inputSectionHeight,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 800,
                ),
                padding: EdgeInsets.all(
                  theme.sizing.spacing1,
                ),
                child: ElevatedCard(
                  elevation: 1,
                  borderRadius: theme.sizing.radius2.asRadius(),
                  child: Container(
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
                        SizedBox(height: theme.sizing.spacing3),
                        const SizedBox(
                          height: 600,
                          child: IngredientWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Container(
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
