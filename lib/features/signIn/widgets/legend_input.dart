import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_widgets/input/form/formfields.dart/legendTextFormField.dart';
import 'package:legend_design_widgets/input/form/legendFormField.dart';
import 'package:legend_design_widgets/input/text/legendInputDecoration.dart';
import 'package:legend_design_widgets/input/text/legendTextField.dart';

class LegendInput extends StatelessWidget {
  final LegendInputDecoration decoration;
  final bool obscureText;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;

  final bool? editable;
  final List<TextInputFormatter>? formatter;
  final TextEditingController? ctrl;
  final TextAlign textAlign;

  final bool error;

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
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);

    return TextField(
      controller: ctrl,
      decoration: decoration,
      cursorColor: decoration.cursorColor,
      textAlignVertical: TextAlignVertical.top,
      textAlign: textAlign,
      inputFormatters: formatter,
      onSubmitted: (value) {
        if (onSubmitted != null) onSubmitted!(value);
      },
      onChanged: (value) {
        if (onChanged != null) onChanged!(value);
      },
      style: theme.typography.h1.copyWith(
        color: decoration.textColor,
      ),
      contextMenuBuilder: (context, editableTextState) {
        return Container();
      },
    );
  }
}