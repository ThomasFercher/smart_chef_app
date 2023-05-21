import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:smart_chef_app/features/home/home.dart';

class SelectableChip extends StatefulWidget {
  final String title;
  final bool selected;
  final bool def;

  final void Function(bool v)? onSelected;
  final void Function()? onDelete;

  const SelectableChip({
    Key? key,
    this.selected = false,
    this.onSelected,
    required this.title,
    this.onDelete,
    this.def = true,
  }) : super(key: key);

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  late bool visible;

  late bool showDelete;

  @override
  void initState() {
    showDelete = false;
    visible = widget.def;
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        visible = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);

    final color = showDelete
        ? theme.colors.error
        : widget.selected
            ? theme.colors.primary
            : theme.colors.background3;

    final height = theme.rVal<double>(s: 42, m: 48, l: 56, xl: 56);

    return GestureDetector(
      onTap: () {
        if (showDelete && !widget.def) {
          setState(() {
            showDelete = false;
          });
          return;
        }
        widget.onSelected?.call(!widget.selected);
      },
      onLongPress: () {
        if (widget.def) return;
        setState(() {
          showDelete = !showDelete;
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            padding: EdgeInsets.symmetric(
              horizontal: visible ? 42 : 8,
            ),
            height: height,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color,
            ),
            child: Column(
              // Workaround since using aligment Center fucks up the Dynamic Row
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: visible ? 1 : 0,
                  child: !showDelete
                      ? LegendText(
                          widget.title,
                          style: theme.typography.h2,
                          selectable: false,
                        )
                      : LegendAnimatedIcon(
                          icon: Icons.delete,
                          padding: const EdgeInsets.all(4),
                          iconSize: 24,
                          theme: LegendAnimtedIconTheme(
                              enabled: theme.colors.error.lighten(0.25),
                              disabled: theme.colors.error.lighten(0.25)),
                          onPressed: () {
                            widget.onDelete?.call();
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
