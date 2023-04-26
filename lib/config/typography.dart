import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legend_design_core/interfaces/typography_delegate.dart';
import 'package:legend_design_core/styles/typography/typography.dart';

class AppTypography extends TypographyDelegate {
  @override
  LegendTypography get typography {
    return LegendTypography(
      h5: GoogleFonts.raleway(fontWeight: FontWeight.bold),
      h4: GoogleFonts.raleway(fontWeight: FontWeight.bold),
      h3: GoogleFonts.raleway(fontWeight: FontWeight.bold),
      h2: GoogleFonts.raleway(),
      h1: GoogleFonts.roboto(),
      h0: GoogleFonts.roboto(),
    );
  }
}
