import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/select_info.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients.dart';
import 'package:smart_chef_app/features/recipe/widgets/content_wrap.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/output/output.dart';
import 'package:smart_chef_app/features/recipe/recipes/recipes_section.dart';

const kPageDuration = Duration(milliseconds: 500);
const kPageCurve = Curves.easeInOut;

class RecipePage extends ConsumerStatefulWidget {
  static String route = "/recipe";

  const RecipePage({Key? key}) : super(key: key);

  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  int lastPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final appBarActions =
        ScaffoldInfo.of(context).scaffold.builders.appBarActions;
    final selectKey = GlobalKey();
    final ingredientsKey = GlobalKey();
    final outputKey = GlobalKey();
    final recipeKey = GlobalKey();
    final sections = [
      RecipeSection(key: recipeKey),
      SelectInfoSection(key: selectKey),
      SelectIngredientsSection(key: ingredientsKey),
      OutputSection(key: outputKey),
    ];

    return LegendRouteBody(
      singlePage: true,
      maxContentWidth: 1200,
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
      listWrapper: (listView, _, __) => ContentWrap(
        sectionLength: sections.length,
        onPageChanged: (index) async {
          final immediate = (index - lastPage) < 0;
          final sectionContext = switch (index) {
            0 => recipeKey.currentContext,
            1 => selectKey.currentContext,
            2 => ingredientsKey.currentContext,
            3 => outputKey.currentContext,
            _ => null,
          };
          if (sectionContext == null) return;
          if (immediate) ref.read(indexProvider.notifier).state = index;
          await Scrollable.ensureVisible(
            sectionContext,
            duration: kPageDuration,
            curve: kPageCurve,
          );
          if (!immediate) ref.read(indexProvider.notifier).state = index;

          lastPage = index;
        },
        child: listView,
      ),
      physics: const NeverScrollableScrollPhysics(),
      slivers: (_) => [
        for (final section in sections)
          SliverToBoxAdapter(
            child: section,
          )
      ],
    );
  }
}

extension<T> on T {
  T? ifElseNull(bool condition) => condition ? this : null;
}

extension RecipeExtension on BuildContext {
  double get viewportHeight => height - theme.appBarSizing.appBarHeight;
}
