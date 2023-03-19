import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legend_design_core/interfaces/typography_delegate.dart';
import 'package:legend_design_core/styles/typography/typography.dart';

class AppTypography extends TypographyDelegate {
  @override
  LegendTypography get typography {
    return LegendTypography(
      h5: GoogleFonts.inter(fontWeight: FontWeight.bold),
      h4: GoogleFonts.inter(fontWeight: FontWeight.bold),
      h3: TextStyle(),
      h2: TextStyle(),
      h1: TextStyle(),
      h0: TextStyle(),
    );
  }
}
