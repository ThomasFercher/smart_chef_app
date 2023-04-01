import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_widgets/input/button/legendButton/legend_button.dart';

class RegistrationSuccessDialog extends LegendWidget {
  const RegistrationSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    const spacer = SizedBox(height: 32);
    return Center(
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colors.background1,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: theme.colors.selection,
              size: 128,
            ),
            spacer,
            LegendText(
              'Registration complete',
              style: theme.typography.h3,
            ),
            spacer,
            Text(
              'Please check your email to verify your account.',
              style: theme.typography.h2,
              textAlign: TextAlign.center,
            ),
            spacer,
            LegendButton(
              background: theme.colors.primary,
              text: LegendText(
                "Continue",
                style: theme.typography.h1,
                color: theme.colors.onPrimary,
                selectable: false,
              ),
              onTap: () => Navigator.of(context).pop(),
              height: 48,
              borderRadius: theme.sizing.radius1.asRadius(),
              selBackground: theme.colors.selection,
              selElevation: 1,
            ),
          ],
        ),
      ),
    );
  }
}
