import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';

const kDuration = Duration(milliseconds: 200);
const kCurve = Curves.easeOutExpo;

class LegendSwitchBar extends StatefulWidget {
  final List<String> items;
  final int selectedIndex;
  final void Function(int)? onSelected;
  final Color? background;
  final Color? selected;
  final double itemWidth;
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle? selectedStyle;
  final TextStyle? textStyle;

  const LegendSwitchBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onSelected,
    this.background,
    this.selected,
    this.itemWidth = 96,
    this.height = 48,
    this.padding = const EdgeInsets.all(4),
    this.textStyle,
    this.selectedStyle,
  }) : assert(items.length > 1, "Items cannot be empty");

  @override
  State<LegendSwitchBar> createState() => _LegendSwitchBarState();
}

class _LegendSwitchBarState extends State<LegendSwitchBar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final _background = widget.background ?? theme.colors.primary;
    final _selected = widget.selected ?? theme.colors.selection;
    final _left = _selectedIndex * widget.itemWidth;
    final _height = widget.height - widget.padding.vertical;

    return Container(
      padding: widget.padding,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1E9),
        color: _background,
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          AnimatedPositioned(
            duration: kDuration,
            left: _left,
            curve: kCurve,
            child: Container(
              width: widget.itemWidth,
              height: _height,
              decoration: BoxDecoration(
                color: _selected,
                borderRadius: BorderRadius.circular(1E9),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.items.length; i++)
                _SwitchItem(
                  text: widget.items[i],
                  itemWidth: widget.itemWidth,
                  textStyle: i == _selectedIndex
                      ? widget.selectedStyle
                      : widget.textStyle,
                  onTap: () {
                    setState(() {
                      _selectedIndex = i;
                    });
                    widget.onSelected?.call(_selectedIndex);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SwitchItem extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double itemWidth;
  final TextStyle? textStyle;

  const _SwitchItem({
    required this.text,
    this.onTap,
    required this.itemWidth,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LegendDetector(
      onTap: onTap,
      borderRadius: BorderRadius.circular(1E9),
      child: Center(
        child: SizedBox(
          width: itemWidth,
          child: LegendText(
            text,
            selectable: false,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
