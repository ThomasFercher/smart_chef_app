import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_sliverbar.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:smart_chef_app/features/home/home.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/select_info.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectInfo/select_info_providers.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/selectIngredients/select_ingredients_providers.dart';
import 'package:smart_chef_app/features/recipe/widgets/content_wrap.dart';
import 'package:smart_chef_app/features/recipe/createRecipe/output/output.dart';
import 'package:smart_chef_app/features/recipe/recipes/recipes_section.dart';
import 'package:smart_chef_app/providers/recipe/recipe_provider.dart';
import 'package:smart_chef_app/services/models/api_ingredient.dart';
import 'package:smart_chef_app/services/models/recipe.dart';

const kPageDuration = Duration(milliseconds: 800);
const kResizeDuration = Duration(milliseconds: 200);
const kPageCurve = Curves.easeInOut;
const resizeCurve = Curves.ease;

class RecipePage extends ConsumerStatefulWidget {
  static String route = "/recipe";

  const RecipePage({Key? key}) : super(key: key);

  @override
  ConsumerState<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends ConsumerState<RecipePage> {
  final selectKey = GlobalKey();
  final ingredientsKey = GlobalKey();
  final outputKey = GlobalKey();
  final recipeKey = GlobalKey();
  int lastPage = 0;

  bool isResisizing = false;

  //TODO: Add kitchen selection
  Recipe buildRecipe(WidgetRef ref) {
    final ingredientMode = ref.read(ingredientModeProvider).value!;
    final tools = ref.read(toolsProvider);
    final ingredients = ref.read(selectedIngredientProvider);
    final difficulty = ref.read(difficultyProvider).value!;
    final servingAmount = ref.read(servingAmountProvider)!;
    final time = ref.read(minuteProvider);

    final recipe = Recipe(
      tools: tools,
      difficulty: difficulty.name,
      servingAmount: servingAmount,
      ingredients: [
        for (final ingredient in ingredients)
          ApiIngredient(ingredient.name, "1"),
      ],
      slection: ingredientMode.name,
    );
    Logger.log("Recipe: $recipe");
    return recipe;
  }

  bool allowedToRecipe(WidgetRef ref) {
    final valid = validateSelectInfo(ref);
    if (!valid) return false;

    final recipe = buildRecipe(ref);
    ref.read(recipeProvider.notifier).getRecipe(recipe);
    return true;
  }

  Future<void> onPageChanged(int index, Duration duration, Curve curve) async {
    final immediate = (index - lastPage) < 0;

    final diff = (index - lastPage);

    final allowNext = switch (index) {
      _ when diff > 0 && index == 2 => allowedToRecipe(ref),
      _ => true,
    };

    if (!allowNext) {
      print("Not allowed");
      return;
    }

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
      duration: duration,
      curve: curve,
    );
    if (!immediate) ref.read(indexProvider.notifier).state = index;

    lastPage = index;
  }

  void recenter() async {
    final index = ref.read(indexProvider);
    if (index == 0 || isResisizing) return;
    //isResisizing = true;
    await onPageChanged(index, kResizeDuration, resizeCurve);
    isResisizing = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final appBarActions =
        ScaffoldInfo.of(context).scaffold.builders.appBarActions;
    final spacer = (context.viewportHeight / 2).vSpacing;
    final sections = [
      RecipeSection(key: recipeKey),
      spacer,
      SelectInfoSection(key: selectKey),
      spacer,
      SelectIngredientsSection(key: ingredientsKey),
      spacer,
      OutputSection(key: outputKey),
      spacer,
    ];

    return RecipeMetricReactor(
      onMetricChange: () {
        recenter();
      },
      child: LegendRouteBody(
        singlePage: false,
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
        disableContentDecoration: true,
        builder: (context, s) {
          return ContentWrap(
            sectionLength: sections.length,
            onPageChanged: (i) => onPageChanged(i, kPageDuration, kPageCurve),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final section in sections) section,
                ],
              ),
            ),
          );
        },
        // slivers: (controller) {
        //   controller.addListener(() {
        //     if (controller.offset > 1000) {
        //       controller.jumpTo(1000);
        //     }
        //   });
        //   return [
        //     for (final section in sections)
        //       SliverToBoxAdapter(
        //         child: AbsorbPointer(absorbing: true, child: section),
        //       )
        //   ];
        // },
      ),
    );
  }
}

extension<T> on T {
  T? ifElseNull(bool condition) => condition ? this : null;
}

extension RecipeExtension on BuildContext {
  double get viewportHeight => height - theme.appBarSizing.appBarHeight;
}

class RecipeMetricReactor extends StatefulWidget {
  final void Function() onMetricChange;
  final Widget child;

  const RecipeMetricReactor({
    Key? key,
    required this.child,
    required this.onMetricChange,
  }) : super(key: key);

  @override
  State<RecipeMetricReactor> createState() => _RecipeMetricReactorState();
}

class _RecipeMetricReactorState extends State<RecipeMetricReactor>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    widget.onMetricChange();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
