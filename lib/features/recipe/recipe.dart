import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:smart_chef_app/features/recipe/output.dart';
import 'package:smart_chef_app/features/recipe/selectInfo/select_info.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/select_ingredients.dart';
import 'package:smart_chef_app/features/recipe/widgets/content_wrap.dart';

class RecipePage extends ConsumerWidget {
  static String route = "/recipe";
  const RecipePage({Key? key}) : super(key: key);

  final List<Widget> sections = const [
    SelectInfoSection(),
    SelectIngredientsSection(),
    OutputSection(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = LegendTheme.of(context);
    final appBarActions =
        ScaffoldInfo.of(context).scaffold.builders.appBarActions;

    final index = ref.watch(indexProvider);
    final initialScrollOffset =
        (SizeInfo.of(context).height + theme.appBarSizing.appBarHeight / 2) *
            index;

    return LegendRouteBody(
      singlePage: true,
      sliverAppBar: LegendSliverBar(
        config: LegendAppBarConfig(
          appBarHeight: theme.appBarSizing.appBarHeight,
          elevation: 1,
          pinned: true,
        ),
        showBackButton: false,
        showMenu: true,
        actions: appBarActions,
      ),
      initalScrollOffset: initialScrollOffset,
      listWrapper: (listView, _, __) {
        return ContentWrap(
          sectionLength: sections.length,
          child: listView,
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      slivers: (scrollcontroller) {
        return [
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return sections[index];
              },
              childCount: sections.length,
            ),
          ),
        ];
      },
    );
  }
}
