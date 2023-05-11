import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';

class CollapsedWidget extends LegendWidget {
  const CollapsedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth == 0 || constraints.maxHeight == 0) {
        return const SizedBox.shrink();
      }

      final isDark = LegendTheme.stateOf(context).isDark;
      return ElevatedBox(
        elevation: 0.5,
        margin: const EdgeInsets.only(left: 8),
        shadowColor: isDark ? theme.colors.foreground1 : null,
        decoration: BoxDecoration(
          borderRadius: theme.sizing.radius2.asRadius(),
          color: theme.colors.background1,
        ),
        child: SizedBox(
          width: theme.appBarSizing.appBarHeight - 24,
          height: theme.appBarSizing.appBarHeight - 24,
          child: GestureDetector(
            onTap: () => ModalRouter.of(context).push(MenuDrawer.route),
            child: Icon(
              Icons.menu,
              color: theme.colors.foreground1,
            ),
          ),
        ),
      );
    });
  }
}
