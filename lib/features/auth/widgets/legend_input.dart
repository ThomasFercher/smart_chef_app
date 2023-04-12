import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_utils/extensions/extensions.dart';

import 'package:smart_chef_app/features/footer/footer.dart';

class LegendInput extends StatefulWidget {
  final InputDecoration decoration;
  final bool obscureText;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;

  final bool? editable;
  final List<TextInputFormatter>? formatter;
  final TextEditingController? ctrl;
  final TextAlign textAlign;
  final double height;
  final bool error;

  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final TextStyle? style;

  const LegendInput({
    super.key,
    required this.decoration,
    this.obscureText = false,
    this.onSubmitted,
    this.onChanged,
    this.editable,
    this.formatter,
    this.ctrl,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.error = false,
    this.focusNode,
    this.height = 24,
    this.cursorColor,
    this.style,
  });

  @override
  State<LegendInput> createState() => _LegendInputState();
}

class _LegendInputState extends State<LegendInput> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);

    // if (kIsWeb) {
    //   document.addEventListener('keydown', (dynamic event) {
    //     if (event.code == 'Tab') {
    //       event.preventDefault();
    //     }
    //   });
    // }

    return TextFormField(
      controller: widget.ctrl,
      decoration: widget.decoration.copyWith(
        suffixIcon: LegendAnimatedIcon(
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
          iconSize: 20,
          padding: const EdgeInsets.only(right: 8),
          icon: isObscured ? Icons.visibility_off : Icons.visibility,
          theme: LegendAnimtedIconTheme(
            enabled: theme.colors.selection,
            disabled: theme.colors.disabled,
          ),
          disableShadow: true,
        ).ifW(widget.obscureText),
        contentPadding: EdgeInsets.symmetric(
          vertical: (widget.height - getTextHeight(theme.typography.h1)) / 2,
          horizontal: 12,
        ),
      ),
      cursorColor: widget.cursorColor ?? theme.colors.primary,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.next,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.formatter,
      focusNode: widget.focusNode,
      minLines: 1,
      maxLines: 1,
      obscureText: isObscured,
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
      style: widget.style ?? theme.typography.h1,
    );
  }
}

InputDecoration geLoginDecoration(
  LegendTheme theme,
  String? errorMessage, {
  String? hintText,
}) =>
    InputDecoration(
      hintText: hintText,
      hintStyle: theme.typography.h0.copyWith(
        color: theme.colors.foreground4,
      ),
      errorText: errorMessage,
      errorStyle: theme.typography.h0.copyWith(
        color: theme.colors.error,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.error,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.foreground4,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.foreground4,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: theme.sizing.radius1.asRadius(),
        borderSide: BorderSide(
          color: theme.colors.selection,
          width: 2,
        ),
      ),
    );

double getTextHeight(TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: 'A', style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size.height;
}
