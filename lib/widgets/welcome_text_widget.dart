// lib/widgets/welcome_text_widget.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'responsive_buttons.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.paragrpah,
    this.customColor = Colors.white,
  });

  final String heading;
  final String subHeading;
  final String paragrpah;
  final Color customColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            textAlign: TextAlign.left,
            heading,
            style: GoogleFonts.raleway(
                color: customColor, fontSize: 29, fontWeight: FontWeight.bold)),
        Text(subHeading,
            style: GoogleFonts.raleway(
                color: customColor, fontSize: 20, fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
        Text(paragrpah,
            style: GoogleFonts.raleway(color: customColor, fontSize: 15)),
        const SizedBox(height: 20),
        // the data api data will be loaded when we click on this button

      ],
    );
  }
}
