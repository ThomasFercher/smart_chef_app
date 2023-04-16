import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/animated_card.dart';

const kDuration = Duration(milliseconds: 500);

class Review extends LegendWidget {
  const Review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return AnimatedCard(
      duration: kDuration,
      elevation: 1,
      background: theme.colors.background4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendText(
              '"',
              style: GoogleFonts.spaceGrotesk(fontSize: 64),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
