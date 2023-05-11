import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:smart_chef_app/features/recipe/selectInfo/select_info.dart';
import 'package:smart_chef_app/features/recipe/selectIngredients/select_ingredients.dart';
import 'package:smart_chef_app/features/recipe/widgets/content_wrap.dart';
import 'package:smart_chef_app/features/recipe/output/output.dart';

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
      listWrapper: (listView, _, __) {
        return ContentWrap(
          sectionLength: sections.length,
          child: listView,
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      slivers: (scrollcontroller) {
        return [
          for (var section in sections)
            SliverFillRemaining(
              child: section,
            ),
        ];
      },
    );
  }
}
