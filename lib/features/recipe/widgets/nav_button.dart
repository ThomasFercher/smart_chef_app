import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';

// final checkRecipeProvider = StateProvider<bool>((ref) {
//   return true;
// });

class NavButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final void Function() onTap;

  const NavButton({
    super.key,
    this.text,
    this.icon,
    required this.onTap,
  }) : assert(text != null || icon != null, "Must provide text or icon");

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  late bool _visible;

  @override
  void initState() {
    _visible = false;
    Future.microtask(() => setState(() {
          _visible = true;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: LegendButton(
        height: 72,
        width: 72,

        background: theme.colors.primary,
        borderRadius: BorderRadius.circular(36),
        text: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.text != null)
              LegendText(
                widget.text,
                selectable: false,
                style: theme.typography.h1,
                color: theme.appBarColors.foreground,
                margin: const EdgeInsets.only(right: 8),
              ),
            if (widget.icon != null)
              Icon(
                widget.icon,
                color: theme.colors.onPrimary,
                size: 30,
              ),
          ],
        ),
        onTap: widget.onTap,
        // List<String> ingedients = [];
        // selectedIngredients.map((e) => ingedients.add(e.name!)).toList();
        // Recipe recipe = Recipe([], [], 2, "Hard", "Selected", null);
        // ref.read(recipeProvider.notifier).getRecipe(recipe);
        // ref.read(indexProvider.notifier).state += 1;
        // ref.read(checkRecipeProvider.notifier).state = false;
        // print(ref.read(checkRecipeProvider));
      ),
    );
  }
}
